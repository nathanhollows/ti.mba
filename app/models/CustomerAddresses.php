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
     * @var string
     */
    public $customerId;

    /**
     *
     * @var string
     */
    public $dateFrom;

    /**
     *
     * @var string
     */
    public $dateTo;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'customer_addresses';
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
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return array(
            'customerAddressId' => 'customerAddressId',
            'customerId' => 'customerId',
            'dateFrom' => 'dateFrom',
            'dateTo' => 'dateTo'
        );
    }

}
