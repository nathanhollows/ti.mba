<?php

namespace App\Controllers;

use Phalcon\Tag;

use App\Forms\KpiForm;
use App\Models\Kpis;
use App\Models\Calendar;
use App\Models\DailySales;
use App\Models\Budgets;
use App\Models\Users;
use App\Forms\DailySalesForm;

class KpiController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Daily KPI\'s');
        $this->response->redirect('kpi/' . date('Y/m/d'));
    }

    public function editAction($year, $month, $day)
    {
        // Set the title
    	$this->tag->prependTitle('Daily KPI\'s');
        // Check if URL is correctly formed date
        if (checkdate($month, $day, $year)) {
            $dateRaw = strtotime("$year-$month-$day");
            $date = date('Y/m/d', $dateRaw);
            $dateSql = date('Y-m-d', $dateRaw);
        } else {
            $this->flash->error("This is not a valid date");
            return true;
        }

        $form = new KpiForm;
        $data = Kpis::findFirst("date = '$date'");
        if ($data) {
            $form = new KpiForm($data, array('date' => $date));
        }
        $this->view->form = $form;
        $this->view->date = $dateSql;

		$this->view->today = false;
		if (date('Y-m-d') === $dateSql) {
			$this->view->today = true;
		}

        $this->view->tomorrow = date('Y/m/d', strtotime($date . "+1 days"));
        $this->view->yesterday = date('Y/m/d', strtotime($date . "-1 days"));

        $calendar = Calendar::findFirst("calendarDate = '$date'");

        if (!$calendar->isWorkDay()) {
            $this->flash->warning("This is not a working day");
        }
    }

    public function saveAction()
    {
        $this->view->disable();

        if (!$this->request->isPost()) {
            return $this->_redirectBack();
        }

        // Check if the date has already been saved before
        $kpi = Kpis::findFirstByDate($this->request->getPost('date'));
        if ($kpi) {
            // If the date HAS been saved the update the data
            $success = $kpi->update($this->request->getPost(), array('chargeOut', 'truckTime', 'onsiteDispatch', 'offsiteDispatch', 'ordersSent'));
        } else {
            // If the data has NOT yet been been saved then submit a new record
            $kpi = new Kpis();
            $success = $kpi->save($this->request->getPost(), array('date','chargeOut', 'truckTime', 'onsiteDispatch', 'offsiteDispatch', 'ordersSent'));
        }

        // Check success and print results
        if ($success) {
            $this->flashSession->success("The data has been updated!");
            return $this->_redirectBack();
        } else {
            $this->flashSession->error("Woops! Something went wrong.");
            foreach ($kpi->getMessages() as $message) {
                $this->flashSession->error($message->getMessage());
            }
            return $this->_redirectBack();
        }

    }

    public function dailysalesAction($year = null, $month = null, $day = null)
    {
        if (!$year || !$month || !$day) {
            $this->response->redirect('kpi/dailysales/' . date('Y/m/d'));
        }

        $this->tag->prependTitle('Daily Sales');

        $date = (date("Y-m-d",strtotime("$year-$month-$day")));

        $this->view->users = Users::getActive();

        $record = new DailySales;
        $record->date = $date;

        $this->view->salesByAgent = DailySales::getDayByRep($date);
        $this->view->total = DailySales::sumDay($date);

        $this->view->form = new DailySalesForm($record);

        $records = DailySales::findByDate($date);
        $this->view->records = $records;

        $this->view->tomorrow = date('Y/m/d', strtotime($date . "+1 days"));
        $this->view->yesterday = date('Y/m/d', strtotime($date . "-1 days"));
        $calendar = Calendar::findFirst("calendarDate = '$date'");

        $this->assets->collection('footer')
            ->addJs('/js/editable-table.js');
        $this->assets->collection('header')
            ->addCss('/css/editable-table.css');

        $this->view->pageTitle = "Daily Sales";
        $this->view->pageSubtitle = date("D, jS F 'y", strtotime($date));

        $this->view->weekTotal = DailySales::sumWeek($date);

        $budget = Budgets::getDate($date);
        $this->view->budget = $budget;

    }

    // TODO Check timestamp of sales to stop data overwriting
    public function savesalesAction()
    {

        $this->view->disable();

        if (!$this->request->getPost()) {
            $this->_redirectBack();
        }

        $data = $this->request->getPost();

        // Let's sort through the checkboxes
        // There is a hidden checkbox which is used as the counter

        // Counter for the loop
        $i = 0;
        $len = count($data['quoted']);

        while($i < $len) {

            if (isset($data['quoted'][$i])) {
                // Set unchecked to checked
                if ($data['quoted'][$i] == 0 and @$data['quoted'][$i + 1] == 1 ) {
                    $data['quoted'][$i] = 1;
                    unset($data['quoted'][$i + 1]);
                }

                // Set unchecked to checked
                 else if ($data['quoted'][$i] == 10 and @$data['quoted'][$i + 1] == 0 ) {
                    $data['quoted'][$i] = 0;
                    unset($data['quoted'][$i + 1]);
                }
            }

            $i ++;
        }

        $data['quoted'] = array_values($data['quoted']);

        // Counter for the loop
        $i = 0;
        $len = count($data['rep']);

        // Loop through each request
        for ($i = 0; $i < count($data['amount'], COUNT_RECURSIVE) - 1; $i++)
        {

            if (empty($data['id'][$i])) {
                $entry = new DailySales;
                $entry->timestamp = date('Y-m-d H:i:s');
            } else {
                $entry = DailySales::findFirstById($data['id'][$i]);
                $snapshot = true;
            }

            $entry->date                    = $data['date'];
            $entry->week                    = date("W",strtotime($data['date']));
            $entry->rep                     = $data['rep'][$i];
            $entry->quoted                  = $data['quoted'][$i];
            $entry->customerReference       = $data['customerReference'][$i];
            $entry->value                   = $data['amount'][$i];

            $success = $entry->save();
            unset($snapshot);


            // Check success and print results
            if (!$success) {
                foreach ($entry->getMessages() as $message) {
                    $this->flashSession->error($message->getMessage());
                }
            }
        }

        $this->_redirectBack();

    }

    public function deletesaleAction($id)
    {
        $this->view->disable();

        $entry = DailySales::findFirstByid($id);

        if (!$entry) {
            $this->flashSession->error("This item could not be found");
            $this->_redirectBack();
        }

        $success = $entry->delete();

        if (!$success) {
            foreach ($entry->getMessages() as $message) {
                $this->flashSession->error($message->getMessage());
            }
        } else {
            $this->flashSession->success("Success! That line was deleted");
        }

        $this->_redirectBack();

    }
}
