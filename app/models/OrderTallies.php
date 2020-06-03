<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class OrderTallies extends Model
{

    /**
     *
     * @var string
     */
    public $orderNumber;

    /**
     *
     * @var integer
     */
    public $itemNumber;

    /**
     *
     * @var int
     */
    public $pieces;

    /**
     *
     * @var int
     */
    public $length;
}
