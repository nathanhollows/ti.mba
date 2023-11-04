<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Budgets extends Model
{

    /**
     *
     * @var string
     */
    public $date;

    /**
     *
     * @var integer
     */
    public $year;

    /**
     *
     * @var int
     */
    public $month;

    /**
     *
     * @var int
     */
    public $days;

    /**
     *
     * @var int
     */
    public $budget;

    public function afterSave()
    {
        $this->getDI()->get('cache')->delete('this-month-budget');
    }

    public function afterCreate()
    {
        $this->getDI()->get('cache')->delete('this-month-budget');
    }

    public static function current()
    {
        $budget = parent::findFirst(array(
            'conditions'    => 'year = ?1 AND month = ?2',
            'bind'          => array(
                1 => date('Y'),
                2 => date('m'),
            ),
            'cache' => [
                'lifetime' => 3600,
                'key' => 'this-month-budget',
            ],
        ));
        return $budget;
    }

    public static function getDate($date = null)
    {
        // If a date is not give, use today
        $date = ($date) ? $date : date('Y-m-01');
        // Get the month and year
        $month = date('m', strtotime($date));
        $year = date('Y', strtotime($date));

        $budget = parent::findFirst(array(
            'conditions'    => 'year = ?1 AND month = ?2',
            'bind'          => array(
                1 => $year,
                2 => $month,
            )
        ));
        return $budget;
    }
}
