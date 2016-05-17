<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Kpis extends Model
{
	public $id;

	public $date;

	public $chargeOut;

	public $sales;

	public $truckTime;

	public $onsiteDispatch;

	public $offsiteDispatch;

	public $monthlyChargeGoal;

	public $dailySalesGoal;

	public $ordersSent;

	public static function thisMonth() {
		return parent::find(
			array(
				"MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())",
				"order" => "date ASC"
			)
		);
	}
	
}