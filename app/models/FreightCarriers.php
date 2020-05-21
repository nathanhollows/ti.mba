<?php

namespace App\Models;

class FreightCarriers extends \Phalcon\Mvc\Model
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
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('id', 'App\Models\Customers', 'freightCarrier', array('alias' => 'Customers'));
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return FreightCarriers
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
