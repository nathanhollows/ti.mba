<?php

namespace App\Models;

class Addresses extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $addressId;

    /**
     *
     * @var string
     */
    public $line1;

    /**
     *
     * @var string
     */
    public $line2;

    /**
     *
     * @var string
     */
    public $line3;

    /**
     *
     * @var string
     */
    public $city;

    /**
     *
     * @var string
     */
    public $region;

    /**
     *
     * @var string
     */
    public $postCode;

    /**
     *
     * @var string
     */
    public $country;

    /**
     *
     * @var string
     */
    public $addressDetails;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'addresses';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Addresses[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Addresses
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
            'addressId' => 'addressId',
            'line1' => 'line1',
            'line2' => 'line2',
            'line3' => 'line3',
            'city' => 'city',
            'region' => 'region',
            'postCode' => 'postCode',
            'country' => 'country',
            'addressDetails' => 'addressDetails'
        );
    }

}
