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


    public static function thisMonth()
    {
        return parent::find(
            array(
                "MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())",
                "order" => "date ASC",
                "cache"	=> [
                    "key"	=> "months-kpis",
                    "lifetime"	=> 500,
                ],
            )
        );
    }

    public static function ofMonthYear($date)
    {
        $year = date("Y", strtotime($date));
        $month = date("m", strtotime($date));
        return parent::find(
            array(
                "MONTH(date) = ?2 AND YEAR(date) = ?1",
                "order" => "date ASC",
                "bind"  => array(
                    1 => $year,
                    2 => $month,
                )
            )
        );
    }
}
