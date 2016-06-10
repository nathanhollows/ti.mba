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
        $this->hasOne('customerStatus', 'App\Models\CustomerStatus', 'id', array('alias' => 'status'));
        $this->hasOne('customerGroup', 'App\Models\CustomerGroups', 'id', array('alias' => 'group'));
        $this->hasOne('salesArea', 'App\Models\SalesAreas', 'id', array('alias' => 'salesarea'));
        $this->hasMany('customerCode', 'App\Models\Addresses', 'customerCode', array('alias'  => 'addresses'));
        $this->hasMany('customerCode', 'App\Models\Contacts', 'customerCode', array('alias' => 'contacts'));
        $this->hasMany('customerCode', 'App\Models\ContactRecord', 'customerCode', array('alias' => 'history'));
        $this->hasMany('customerCode', 'App\Models\Quotes', 'customerCode', array('alias' => 'quotes'));
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


    public static function getName($customerCode = null)
    {
        $customer = parent::findFirstByCustomerCode($customerCode);
        return $customer->customerName;
    }

}
