<?php

namespace App\Models;

class CustomerAddresses extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $customerAddressId;

    /**
     *
     * @var integer
     */
    public $addressId;

    /**
     *
     * @var integer
     */
    public $typeCode;

    /**
     *
     * @var string
     */
    public $customerCode;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('customerAddressId', 'App\Models\Customers', 'defaultAddress', array('alias' => 'Customers'));
        $this->belongsTo('addressId', 'App\Models\Addresses', 'id', array('alias' => 'Addresses'));
        $this->belongsTo('typeCode', 'App\Models\AddressTypes', 'typeCode', array('alias' => 'AddressTypes'));
        $this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'Customers'));
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerAddresses[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerAddresses
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
        return 'customer_addresses';
    }

}
