<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class DailySales extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $date;

    /**
     *
     * @var int
     */
    public $quoted;

    /**
     *
     * @var string
     */
    public $customerReference;

    /**
     *
     * @var decimal
     */
    public $value;

    /**
     *
     * @var integer
     */
    public $rep;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasOne('rep', 'App\Models\Users', 'id', array('alias' => 'agent'));
    }

    public function afterSave()
    {
        $date = date("Y-m-d", strtotime($this->date));
        $this->di->get('modelsCache')->deleteMultiple([
            "week-sales-{$date}", "month-sales-{$date}",
        ]);
    }

    public static function sumWeek($date = null)
    {
        $results = parent::sum([
            'column'        => 'value',
            'conditions'    => 'WEEK(date) = WEEK(?1) AND YEAR(date) = YEAR(?1)',
            'bind'          => array(1 => $date),
            "cache"			=> [
                "key"	=> "week-sales-$date",
            ],
            ]);
        return $results;
    }

    public static function sumMonth($date = null)
    {
        if (is_null($date)) {
            $date = date("Y-m-d");
        } else {
            $date = date("Y-m-d", strtotime($date));
        }

        $results = parent::sum([
            'column' => 'value',
            'conditions'  => 'MONTH(date) = MONTH(?1) AND YEAR(date) = YEAR(?1)',
            'bind'  => array(1 => $date),
            "cache"			=> [
                "key"	=> "month-sales-$date",
            ],
        ]);
        return $results;
    }

    public static function countMonth($date = null)
    {
        if (is_null($date)) {
            $date = date("Y-m-d");
        } else {
            $date = date("Y-m-d", strtotime($date));
        }

        $results = parent::count(
            array(
                'column' => 'value',
                'conditions'  => 'MONTH(date) = MONTH(?1) AND YEAR(date) = YEAR(?1)',
                'bind'  => array(1 => $date),
            )
        );
        return $results;
    }

    public static function countQuotesMonth($date)
    {
        return parent::count(
            array(
                "conditions"    => "YEAR(date) = YEAR(?1) AND MONTH(date) = MONTH(?1) AND quoted = 1",
                "bind"          => array(1 => $date),
            )
        );
    }

    public static function sumQuotesMonth($date)
    {
        return parent::sum(
            array(
                "column"        => "value",
                "conditions"    => "YEAR(date) = YEAR(?1) AND MONTH(date) = MONTH(?1) AND quoted = 1",
                "bind"          => array(1 => $date),
            )
        );
    }

    public static function sumDay($date)
    {
        return parent::sum(
            array(
                'column'        => 'value',
                'conditions'    => 'date = ?1',
                'bind'          => array(1 => date('Y-m-d', strtotime($date))),
            )
        );
    }

    public static function dailySalesBetween($start, $end)
    {
        if (date_parse($start) and date_parse($end)) {
            return parent::sum(array(
                'column'        => 'value',
                'conditions'    => 'date BETWEEN ?1 AND ?2',
                'group'         => 'date',
                'bind'          => array(
                    1 => $start,
                    2 => $end,
                ),
            ));
        }
    }

    public static function sumSalesBetween($start, $end)
    {
        if (date_parse($start) and date_parse($end)) {
            return parent::sum(array(
                'column'        => 'value',
                'conditions'    => 'date BETWEEN ?1 AND ?2',
                'bind'          => array(
                    1 => $start,
                    2 => $end,
                ),
            ));
        }
    }

    public static function getDayByRep($date)
    {
        return parent::sum(
            array(
                'column'        => 'value',
                'group'         => 'rep',
                'order'         => 'sumatory DESC',
                "conditions"    => "date = ?1",
                "bind"          => array(1 => $date),
            )
        );
    }

    public static function getMonthByRep($date)
    {
        return parent::sum(
            array(
                'column'        => 'value',
                'group'         => 'rep',
                'order'         => 'sumatory DESC',
                "conditions"    => "YEAR(date) = YEAR(?1) AND MONTH(date) = MONTH(?1)",
                "bind"          => array(1 => $date),
            )
        );
    }
}
