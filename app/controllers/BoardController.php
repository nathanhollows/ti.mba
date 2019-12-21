<?php

namespace App\Controllers;

use App\Models\Budgets;
use App\Models\DailySales;
use App\Models\Kpis;
use App\Models\Quotes;
use App\Models\ContactRecord;

/**
 *  This controller is not blacklisted in the ACL
 *  A RPI can now access this page with auto refresh enabled without sessions timing out
 *
 */

class BoardController extends ControllerBase {

	public function initialize() {
		$this->view->setTemplateBefore('none');
		parent::initialize();
	}

	// Action to generate TV dashboard view
	public function fb61dfafcfa450b9d19065817ce3ccdAction($year = null, $month = null, $day = null) {

		if (!$year || !$month || !$day) {
			$year = date("Y");
			$month = date("m");
			$day = date("d");
		}

		$this->view->month = Kpis::thisMonth();

		$dateRaw = strtotime("$year-$month-$day");
		$date = date('Y-m-d', $dateRaw);

		$this->view->date = $date;

		$data = Kpis::findFirstByDate($date);
		if (!$data) {
			$data = Kpis::find(array('order' => 'date ASC'));
			$data = $data->getLast();
		}

		$this->view->data = $data;
		$salesDate = $data->date;
		$this->view->daySales = DailySales::sumDay($salesDate);
		$this->view->sales = DailySales::dailySalesBetween(date("Y-m-01", strtotime($salesDate)), $salesDate);
		$this->view->totalSales = DailySales::sumSalesBetween(date("Y-m-01", strtotime($salesDate)), $salesDate);
		$this->view->kpis = Kpis::ofMonthYear($salesDate);
		$this->view->budget = Budgets::getDate($salesDate);

		$this->assets->collection('header')
			->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');

		$this->assets->collection('dashfooter')
			->addJs('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.js');

	}

	public function e0af2c77ed42f2a825526e04e9abdbAction() {
		$date = strtotime("NOW - 1 MONTH");

		$onsite = Kpis::sum(array(
			"column" => "onsiteDispatch",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW())",
			"bind" => [
				1 => $date,
			],
		));
		$this->view->onsite = $onsite;

		$offsite = Kpis::sum(array(
			"column" => "offsiteDispatch",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW())",
			"bind" => [
				1 => $date,
			],
		));
		$this->view->offsite = $offsite;

		$ordersSent = Kpis::sum(array(
			"column" => "ordersSent",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW())",
			"bind" => [
				1 => $date,
			],
		));
		$this->view->ordersSent = $ordersSent;

		$chargeOut = Kpis::maximum(array(
			"column" => "chargeOut",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW())",
			"bind" => [
				1 => $date,
			],
		));
		$this->view->chargeOut = $chargeOut;

		$prevChargeOut = Kpis::maximum(array(
			"column" => "chargeOut",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW()) - 1",
			"bind" => [
				1 => $date,
			],
		));
		$this->view->prevChargeOut = $prevChargeOut;

		$biggestSale = DailySales::maximum(array(
			"column" => "value",
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW())",
		));
		$biggestSale = DailySales::findFirst(array(
			"conditions" => "MONTH(date) = MONTH(NOW()) -1 AND YEAR(date) = YEAR(NOW()) AND value = ?1",
			"bind" => [
				1 => $biggestSale,
			],
		));
		$this->view->biggestSale = $biggestSale;

		$this->view->budget = Budgets::getDate($date);
	}

    /**
     * Dashboard for ATS, Architectural and VidaSpace
     */
	public function multiAction() {
		$this->view->atsBudget = Budgets::current();
		$this->view->atsSales = DailySales::sumDay(date("Y-m-d"));
        $this->view->atsLeads = ContactRecord::getOverdueTotal();
    }

    /**
     * Mobile Dashboard for ATS, Architectural and VidaSpace
     */
    public function mobileAction() {
        $budget = Budgets::current();
        $this->view->data = self::getData(0);
    }

    /**
     * Calculates current KPI's and percentages of goals
     * @return JSON
     */
    public function refreshAction() {
        $this->view->disable();

        $this->response->setContentType('application/json', 'UTF-8');

        $data = self::getData($this->request->getPost('atsLeads'));

		$this->response->setContent(json_encode($data));

		return $this->response->send();
	}

    /**
     * Fetches data for dashboards
     * @param  postdata
     * @return array    returns value and percentage of target
     */
    private static function getData($postData)
    {
        $budget = Budgets::current();
        $atsBudget = $budget->budget / $budget->days;
        $atsSales = (float) DailySales::sumDay(date("Y-m-d"));
        $atsLeads = ContactRecord::getOverdueTotal();

        exec('C:\xampp\htdocs\app\script\chargeout.py', $output, $return);

        return [
            'atsSales' => [
                'value'     => $atsSales,
                'rotation'  => self::rotation($atsSales, $atsBudget),
            ],
            'atsChargeOut' => [
                'value'     => $output[0] * 1500,
                'rotation'  => self::rotation($output[0], $atsBudget / 1500),
            ],
            'atsLeads' => [
                'value'     => $postData - $atsLeads,
                'rotation'  => self::rotation($postData - $atsLeads, $atsLeads),
            ],
        ];
    }

    /**
     * calculated the percentage of the goal met, caps at 100
     * @param  int $top    value to be compared
     * @param  int $bottom value to check agianst
     * @return integer
     */
    private static function rotation($top, $bottom)
    {
        $value = (int) ($top / $bottom * 100);
        if ($value > 100) {
            return 100;
        } else {
            return $value;
        }
    }

}
