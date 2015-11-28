<?php

namespace App\Models;

class AddressTypes extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $typeCode;

    /**
     *
     * @var string
     */
    public $typeDescription;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('typeCode', 'App\Models\CustomerAddresses', 'typeCode', array('alias' => 'CustomerAddresses'));
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return AddressTypes[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return AddressTypes
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
        return 'address_types';
    }

}
