<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Calendar extends Model
{
    public $calendarDate;

    public $day;

    public $month;

    public $year;

    public $dayOfWeek;

    public $dayOfMonth;

    public $dayOfYear;

    public $weekOfMonth;

    public $weekday;

    public $weekend;

    public $wprkDay;

    public $payday;

    public $holiday;

    public function nextWorkingDay()
    {
    }

    public function previousWorkingDay()
    {
    }

    public function isWeekend()
    {
        if ($this->weekend == 1) {
            return true;
        }
    }

    public function isWorkDay()
    {
        if ($this->workDay == 1) {
            return true;
        }
    }
}
