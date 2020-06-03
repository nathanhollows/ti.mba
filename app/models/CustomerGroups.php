<?php

namespace App\Models;

class CustomerGroups extends \Phalcon\Mvc\Model
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
    public $headOffice;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('id', 'App\Models\Customers', 'customerGroup', array('alias' => 'Customers'));
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerGroups
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
}
