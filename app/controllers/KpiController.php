<?php

namespace App\Controllers;

use Phalcon\Tag;

use App\Forms\KpiForm,
    App\Models\Kpis,
    App\Models\Calendar;

class KpiController extends ControllerBase
{

	public function initialize()
	{
        $this->view->setTemplateBefore('private');
        parent::initialize();
	}

    public function indexAction()
    {
    	$this->tag->prependTitle('KPI');
        $this->response->redirect('kpi/' . date('Y/m/d'));
    }

    public function editAction($year, $month, $day)
    {
        // Set the title
    	$this->tag->prependTitle('KPI');
        // Check if URL is correctly formed date
        if (checkdate($month, $day, $year)) {
            $dateRaw = strtotime("$year-$month-$day");
            $date = date('Y/m/d', $dateRaw);
        } else {
            $this->flash->error("This is not a valid date");
            return true;
        }

        $form = new KpiForm;
        $data = Kpis::findFirst("date = '$date'");
        if ($data) {
            $form = new KpiForm($data);
        }
        $this->view->form = $form;

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
            $success = $kpi->update($this->request->getPost(), array('chargeOut', 'sales', 'truckTime', 'onsiteDispatch', 'offsiteDispatch', 'ordersSent'));
        } else {
            // If the data has NOT yet been been saved then submit a new record
            $kpi = new Kpis();
            $success = $kpi->save($this->request->getPost(), array('date','chargeOut', 'sales', 'truckTime', 'onsiteDispatch', 'offsiteDispatch', 'ordersSent'));
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

    // Action to generate TV dashboard view
    public function dashboardAction($year = null, $month = null, $day = null)
    {
        if (!$year || !$month || !$day) {
            $this->response->redirect('kpi/dashboard/' . date('Y/m/d'));
        }

        $this->view->month = Kpis::thisMonth();

        $dateRaw = strtotime("$year-$month-$day");
        $date = date('Y-m-d', $dateRaw);

        $this->view->date = $date;

        $data = Kpis::findFirstByDate($date);
        $this->view->data = $data;

        $this->view->setTemplateBefore('none');

        $this->assets->collection('header')
            ->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');
        
        $this->assets->collection('footer')
            ->addJs('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.js')
            ->addJs('js/dashboard/charts.js');

    }
}
