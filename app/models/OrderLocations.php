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
     * @var string
     */
    public $customerCode;

    public function initialize()
    {
        
    }

}
