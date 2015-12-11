<?php

namespace App\Models;

class Customers extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     */
    public $customerCode;

    /**
     *
     * @var string
     */
    public $customerName;

    /**
     *
     * @var string
     */
    public $customerPhone;

    /**
     *
     * @var string
     */
    public $customerFax;

    /**
     *
     * @var string
     */
    public $customerEmail;

    /**
     *
     * @var integer
     */
    public $freightArea;

    /**
     *
     * @var integer
     */
    public $freightCarrier;

    /**
     *
     * @var integer
     */
    public $salesArea;

    /**
     *
     * @var integer
     */
    public $customerStatus;

    /**
     *
     * @var integer
     */
    public $defaultAddress;

    /**
     *
     * @var integer
     */
    public $defaultContact;

    /**
     *
     * @var integer
     */
    public $customerGroup;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasOne('freightCarrier', 'App\Models\FreightCarriers', 'id', array('alias' => 'freightcarrier'));
        $this->hasOne('freightArea', 'App\Models\FreightAreas', 'id', array('alias' => 'freightarea'));
        $this->hasOne('customerStatus', 'App\Models\customerStatus', 'id', array('alias' => 'status'));
        $this->hasOne('customerGroup', 'App\Models\customerGroups', 'id', array('alias' => 'customergroup'));
        $this->hasMany('customerCode', 'App\Models\customerAddress', 'customerCode', array('alias'  => 'addresses'));
        $this->hasMany('customerCode', 'App\Models\Contacts', 'customerCode', array('alias' => 'contacts'));
    }


    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Customers[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Customers
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
        return 'customers';
    }

}
