<?php

namespace App\Controllers;

use Phalcon\Tag;
use App\Models\Customers;
use App\Models\SalesAreas;
use App\Models\Users;
use App\Models\Quotes;
use App\Models\DailySales;
use App\Models\SalesBudget;
use App\Models\SurveyResults;
use App\Models\Budgets;
use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Mvc\Model\Query;

class ReportsController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Reports');
    }

    public function tripPlannerAction()
    {
        $this->tag->prependTitle('Trip Planner');

        $this->view->customers = Customers::find(array(
            'conditions' => 'status IN (1, 2)',
            'order'      => 'name',
            'cache'      => array(
                'key'      => 'customers',
                'lifetime' => 3600,
            ),
        ));

        $unassignedAreas = SalesAreas::find(array(
            'conditions'    => 'agent IS NULL',
            'cache'         => array(
                'key'       => 'unassigned-areas',
                'lifetime'  => 86400
            ),
        ));
        if (count($unassignedAreas) > 0) {
            $this->flash->notice("There are " . count($unassignedAreas) . " sales areas without an assigned rep. You can assign them <strong>" . \Phalcon\Tag::linkTo(array('settings/salesareas', 'here')) . "</strong>.");
        }
    }

    public function annualAction($year = null, $month = null)
    {
        if (date('m')<4) {
            $year = ($year) ? $year : date("Y")-1 ;
        } else {
            $year = ($year) ? $year : date("Y");
        }
        $this->view->year = $year;
        $month = ($month) ? $month : '04' ;
        $start = date('Y-m-d', strtotime("$year-$month-01"));
        $end = date('Y-m-d', strtotime("$year-$month-01 + 12 MONTHS - 1 DAY"));
        $this->view->startMonth = date('F', strtotime($start));
        $this->view->start = $start;

        $this->tag->prependTitle('Annual Sales Report');
        $this->view->pageTitle = 'Annual Sales Report';
        $this->view->pageSubtitle = date('M Y', strtotime($start)) . ' - ' . date('M Y', strtotime($end));

        $builder = new Builder();
        $budget = $builder
            ->columns('c.calendarDate as date, b.budget, b.days')
            ->addFrom('App\Models\Calendar', 'c')
            ->leftJoin('App\Models\Budgets', 'b.month = c.month', 'b')
            ->where('c.calendarDate BETWEEN :start: AND :end: AND c.day = 1 and c.financialYear = :year:')
            ->orderBy('c.calendarDate')
            ->limit(12)
            ->getQuery()
            ->execute([
                'start' => $start,
                'end'   => $end,
                'year'  => $year,
            ]);

        $running = [];
        foreach ($budget as $key => $value) {
            $running[$key]['date'] = $value->date;
            $running[$key]['budget'] = $value->budget;
            $running[$key]['days'] = $value->days;
        }
        $this->view->budget = $running;

        $builder = new Builder();
        $this->view->orderCount = $builder
            ->columns([
                'c.month',
                'c.year',
                'count' => 'COUNT(d.date)',
                'average' => 'AVG(d.value)',
                'sumatory' => 'SUM(d.value)'
            ])
            ->addFrom('App\Models\Calendar', 'c') // Starting from Calendar table
            ->leftJoin('App\Models\DailySales', 'd.date = c.calendarDate', 'd') // Left join DailySales table on month and year
            ->where('c.calendarDate BETWEEN :start: AND :end: AND c.financialYear = :year:') // Conditions for the date
            ->groupBy(['c.year', 'c.month']) // Group by year and month based on the Calendar date
            ->orderBy('c.year ASC, c.month ASC') // Order by year and month
            ->limit(12)
            ->getQuery()
            ->execute([
                'start' => $start,
                'end'   => $end,
                'year'  => $year,
            ]);
            $builder = new Builder();
            $this->view->salesOut = $builder
                ->columns([
                    'c.calendarDate as date', // assuming 'calendarDate' is the column in your Calendar model that represents the date
                    'MAX(k.chargeOut) as salesOut', 
                ])
                ->addFrom('App\Models\Calendar', 'c') // Starting from Calendar table
                ->leftJoin('App\Models\Kpis', 'k.date = c.calendarDate', 'k') // Left join Kpis table
                ->where('c.calendarDate BETWEEN :start: AND :end: AND c.financialYear = :year:') // Conditions for the date
                ->groupBy('month') // Group by month based on the Calendar date
                ->orderBy('c.calendarDate') // Order by the Calendar date
                ->limit(12)
                ->getQuery()
                ->execute([
                    'start' => $start,
                    'end'   => $end,
                    'year'  => $year,
                ]);
                
                
            $query = new Query(
            "SELECT c.month, c.year, (
				SELECT count(*)
				FROM App\Models\Quotes
				WHERE month(date) = c.month 
				AND year(date) = c.year
			) as count
			FROM App\Models\Calendar c
			WHERE financialYear = :year:
			GROUP BY c.month, c.year
			ORDER BY c.year, c.month",
            $this->di
        );
        $this->view->quotesPresented = $query->execute(["year" => date("Y", strtotime($end))]);

        $query = new Query(
            "SELECT c.month, c.year, (
				SELECT count(*)
				FROM App\Models\Quotes
				WHERE month(date) = c.month 
				AND year(date) = c.year
				AND status = 5
			) as count
			FROM App\Models\Calendar c
			WHERE financialYear = :year:
			GROUP BY c.month, c.year
			ORDER BY c.year, c.month",
            $this->di
        );
        $this->view->quotesWon = $query->execute(["year" => date("Y", strtotime($end))]);

        $builder = new Builder();
        $sales = $builder
            ->from('App\Models\DailySales')
            ->leftJoin('App\Models\Users', 'rep = users.id', 'users')
            ->columns(array('sumatory' => 'SUM(value)', 'month' => 'MONTH(date)', 'year' => 'YEAR(date)', 'users.name'))
            ->betweenWhere('date', $start, $end)
            ->groupBy('name, month')
            ->orderBy('FIELD(name,"fax")')
            ->getQuery()
            ->execute();

        $running = [];
        foreach ($sales as $key => $i) {
            $running[$i['name']][$i['month']] = $i['sumatory'];
        }
        $this->view->sales = $running;
    }

    public function telesalesAction($area = null, $day = null)
    {
        $this->tag->prependTitle('Telesales Report');
        $this->view->setTemplateBefore('none');

        if (!$this->request->isPost()) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }

        if (!is_null($this->request->getPost('customerCode'))) {
            (string) $str = null;
            $i = 1;
            foreach ($this->request->getPost('customerCode') as $code) {
                if ($i == 1) {
                    $i++;
                    $str = "'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                } else {
                    $str = $str . ",'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                }
            }
            $this->view->customers = Customers::find(array(
                'conditions'    => "customerCode IN ($str)",
            ));
        }

        if (count($this->view->customers) == 0) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }
    }

    public function customerdetailsAction()
    {
        $this->tag->prependTitle('Customer Details');
        $this->view->setTemplateBefore('none');

        if (!$this->request->isPost()) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }

        if (!is_null($this->request->getPost('customerCode'))) {
            (string) $str = null;
            $i = 1;
            foreach ($this->request->getPost('customerCode') as $code) {
                if ($i == 1) {
                    $i++;
                    $str = "'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                } else {
                    $str = $str . ",'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                }
            }
            $this->view->customers = Customers::find(array(
                'conditions'    => "customerCode IN ($str)",
            ));
        }

        if (count($this->view->customers) == 0) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }
    }

    public function customerhistoryAction()
    {
        $this->tag->prependTitle('Customer History');
        $this->view->setTemplateBefore('none');

        if (!$this->request->isPost()) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }

        $this->view->date = date("Y-m-d", strtotime($this->request->getPost('date')));

        if (!is_null($this->request->getPost('customerCode'))) {
            (string) $str = null;
            $i = 1;
            foreach ($this->request->getPost('customerCode') as $code) {
                if ($i == 1) {
                    $i++;
                    $str = "'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                } else {
                    $str = $str . ",'" . preg_replace("/[^[:alnum:]]/u", '', $code) . "'";
                }
            }
            $this->view->customers = Customers::find(array(
                'conditions'    => "customerCode IN ($str)",
            ));
        }

        if (count($this->view->customers) == 0) {
            $this->flashSession->error('No customers were selected');
            return $this->_redirectBack();
        }
    }

    public function salesAction($year = null, $month = null)
    {
        $this->view->pageTitle = "Monthly Sales Summary";

        $this->tag->prependTitle('Sales Report');

        if (checkdate($month, 01, $year)) {
            $startTime = strtotime("$year-$month-01");
            $endTime = strtotime(date("Y-m-t", $startTime));
        } else {
            $startTime = strtotime(date("Y-m-01"));
            $endTime = strtotime(date("Y-m-t"));
        }

        $this->view->headerButton = '
            <button type="button" class="btn btn-info" id="datebutton">
                <input type="text" name="" id="datepicker" class="form-control" value="' . date("Y/m", $startTime). '" required="required" pattern="" title="" hidden="true">
                <i class="fa fa-icon fa-calendar"></i>
                Select Month ...
            </button>
        ';

        $this->view->pageSubtitle = date("M Y", $startTime);

        // Loop between timestamps, 24 hours at a time
        $weeks = array();
        for ($i = $startTime; $i <= $endTime; $i = $i + 86400) {
            array_push($weeks, date('W', $i));
        }

        $start = date("Y-m-d", $startTime);
        $end = date("Y-m-d", $endTime);

        $weeks = array_unique($weeks);

        (string) $str = null;
        $i = 1;
        foreach ($weeks as $week => $number) {
            if ($i == 1) {
                $i++;
                $str = $number;
            } else {
                $str = $str . "," . $number;
            }
        }

        $weeklySales = DailySales::find(array(
            'columns'        => array('sumatory' => 'SUM(value)', 'rep', 'week', 'count' => 'COUNT(value)'),
            'conditions' => 'YEAR(date) = ?1 AND MONTH(date) = ?2',
            'bind' => array(1 => date("Y", $startTime),2 => date("m", $startTime)),
            'group'         => 'week, rep',
            'order'         => 'week ASC, rep',
        ));

        $this->view->sumMonth = DailySales::sumMonth($start);
        $this->view->countMonth = DailySales::countMonth($start);

        $monthSales = DailySales::find(array(
            'columns'        => array('sumatory' => 'SUM(value)', 'rep', 'count' => 'COUNT(value)'),
            'conditions'    => 'YEAR(date) = ?1 AND MONTH(date) = ?2',
            'bind'          => array( 1 => date("Y", $startTime), 2 => date("m", $startTime) ),
            'group'         => 'rep',
            'order'         => 'sumatory DESC',
        ));

        $new_array = array();
        foreach ($weeklySales as $row) {
            $new_array[$row['week']][$row['rep']] = array('value' => $row->sumatory, 'rep' => $row->rep, 'count' => $row->count);
        }

        $this->view->users = Users::find();
        $this->view->agentWeeklySales = $new_array;
        $this->view->monthSales = $monthSales;
        $this->view->sales = DailySales::dailySalesBetween($start, $end);
        $this->view->budget = Budgets::findFirst(array(
            'conditions' => 'year = ?1 AND month = ?2',
            'bind'       => array(
                1   => date('Y', strtotime($start)),
                2   => date('m', strtotime($start)),
            )
        ));

        $this->assets->collection('header')
            ->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');

        $this->assets->collection('footer')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.2/Chart.bundle.min.js')
            ->addJs('js/dashboard/charts.js');
    }

    public function salesteamAction()
    {
        $this->tag->prependTitle('Sales Team Report');

        $sales = DailySales::find(array(
            'columns'    => array(
                'sum'   => 'SUM(value)',
                'count' => 'COUNT(value)',
                'rep',
            ),
            'conditions'    => 'date > :date:',
            'group'         => 'rep',
            'order'         => 'sum DESC',
            'bind'          => array(
                'date'  => date('Y-m-d', strtotime("now - 1 month")),
            ),
        ));
        $this->view->sales = $sales;

        $this->view->quotesWon = DailySales::find(array(
            'columns'    => array(
                'sum'   => 'SUM(value)',
                'count' => 'COUNT(value)',
                'rep',
            ),
            'conditions'    => 'date > :date: AND quoted = 1',
            'group'         => 'rep',
            'order'         => 'sum DESC',
            'bind'          => array(
                'date'  => date('Y-m-d', strtotime("now - 1 month")),
            ),
        ));

        $this->view->presented = Quotes::find(array(
            'columns'    => array(
                'sum'   => 'SUM(value)',
                'count' => 'COUNT(value)',
                'user',
            ),
            'conditions'    => 'date > :date:',
            'group'         => 'user',
            'order'         => 'sum DESC',
            'bind'          => array(
                'date'  => date('Y-m-d', strtotime("now - 1 month")),
            ),
        ));
    }

    public function surveyAction()
    {
        $this->tag->prependTitle("Survey Results");
        $count = SurveyResults::count();
        $this->view->count = $count;
        $this->view->results = SurveyResults::find(array(
            'order' => 'id DESC',
        ));

        $last = SurveyResults::findFirst(array(
            'columns' => 'timestamp',
            'order'   => 'id DESC',
            'limit'   => 1,
        ));

        $this->view->count = SurveyResults::count();
        $this->view->count1 = SurveyResults::countResults('result1');
        $this->view->count2 = SurveyResults::countResults('result2');
        $this->view->count3 = SurveyResults::countResults('result3');
        $this->view->count4 = SurveyResults::countResults('result4');
        $this->view->count5 = SurveyResults::countResults('result5');
        $this->view->count6 = SurveyResults::countResults('result6');
        $this->view->count7 = SurveyResults::countResults('result7');
        $this->view->count8 = SurveyResults::countResults('result8');
        $this->view->recommend = SurveyResults::countResults('recommend');

        $date = date('Y-m-d', strtotime($last->timestamp));

        $this->view->pageSubtitle = "Last received $date";
        $this->view->pageTitle = "$count received";

        $this->assets->collection('footer')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/jquery-sparklines/2.1.2/jquery.sparkline.min.js');
    }

    public function topcustomersAction()
    {
    }
}
