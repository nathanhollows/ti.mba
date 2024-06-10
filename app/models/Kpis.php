<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query\Builder;
use DateTime;
use DateInterval;
use DatePeriod;

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
    
    public function afterSave() {
        $this->di->get('modelsCache')->deleteMultiple([
            "week-sales-{$this->date}", "months-kpis",
        ]);
    }
    
    public static function thisMonth()
    {
        return parent::find(
            array(
                "MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())",
                "order" => "date ASC",
                "cache"	=> [
                    "key"	=> "months-kpis",
                    "lifetime"	=> 3600,
                ],
            )
        );
    }
    
    public static function dashboardKpis()
    {
        // Calculate number of weekdays in the current month
        $start_date = new DateTime("first day of this month");
        $end_date = new DateTime("last day of this month");
        $interval = DateInterval::createFromDateString('1 day');
        $period = new DatePeriod($start_date, $interval, $end_date);

        $weekdays = array_filter(iterator_to_array($period), function ($dt) {
            return !in_array($dt->format('N'), [6, 7]); // 6 and 7 are Saturday and Sunday
        });

        $numberOfWeekdays = count($weekdays);

        // Fetch N+1 days worth of data to allow for chargeOut calculation
        $numberOfDaysToFetch = $numberOfWeekdays + 1;

        $builder = new Builder();
        $results = $builder
        ->columns([
            'ds.date',
            'SUM(ds.value) AS sales',
            'k.chargeOut',
            'IF(MONTH(ds.date) = MONTH(CURDATE()), true, false) AS current'
            ])
        ->from(['ds' => DailySales::class])
        ->leftJoin(Kpis::class, 'ds.date = k.date', 'k')
        ->limit($numberOfDaysToFetch)
        ->groupBy('ds.date, k.chargeOut')
        ->orderBy('ds.date desc')
        ->getQuery()
        ->execute();

        $previousChargeOut = null;
        $adjustedResults = [];
        $month = null;

        $reversedResults = array_reverse(iterator_to_array($results));
        
        foreach ($reversedResults as $result) {

            // Skip the first result
            if (is_null($previousChargeOut)) {
                $previousChargeOut = $result->chargeOut;
            }

            if ($month != $result->current) {
                $previousChargeOut = 0;
                $month = $result->current;
            }

            // Calculate chargeOut
            $chargeOut = $result->chargeOut - $previousChargeOut;
            if ($chargeOut < 0) {
                $chargeOut = null;
            }
            
            $entry = new \stdClass();
            $entry->date = $result->date;
            $entry->sales = $result->sales;
            $entry->chargeOut = $chargeOut;
            $entry->current = $result->current;
            
            $adjustedResults[] = $entry;
            
            $previousChargeOut = $result->chargeOut;
        }

        // Remove the first result
        array_shift($adjustedResults);
        return $adjustedResults;
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
