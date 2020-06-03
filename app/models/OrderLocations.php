<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class OrderLocations extends Model
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
    public $name;

    /**
     *
     * @var string
     */
    public $description;

    /**
     *
     * @var int
     */
    public $active;

    /**
     *
     * @var string
     */
    public $customerCode;

    public function initialize()
    {
        $this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
    }
}
