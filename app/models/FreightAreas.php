<?php

namespace App\Models;

class FreightAreas extends \Phalcon\Mvc\Model
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
        $this->belongsTo('id', 'App\Models\Customers', 'freightArea');
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return FreightAreas
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
