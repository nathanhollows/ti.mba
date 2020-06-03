<?php

namespace App\Models;

class SalesBudget extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $year;

    /**
     *
     * @var interger
     */
    public $month;

    /**
     *
     * @var float
     */
    public $budget;

    /**
     *
     * @var float
     */
    public $ytd_budget;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
    }
}
