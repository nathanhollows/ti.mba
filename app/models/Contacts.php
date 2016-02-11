<?php

namespace App\Models;

class Contacts extends \Phalcon\Mvc\Model
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
    public $customerCode;

    /**
     *
     * @var string
     */
    public $firstName;

    /**
     *
     * @var string
     */
    public $lastName;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var string
     */
    public $directDial;

    /**
     *
     * @var string
     */
    public $cellPhone;

    /**
     *
     * @var string
     */
    public $position;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Contacts[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Contacts
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'contacts';
    }

}
