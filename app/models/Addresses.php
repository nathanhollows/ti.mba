<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Addresses extends Model
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
     * @var int
     */
    public $typeCode;

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
    public $suburb;

    /**
     *
     * @var string
     */
    public $zipCode;

    /**
     *
     * @var string
     */
    public $city;

    /**
     *
     * @var string
     */
    public $country;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasOne('typeCode', 'App\Models\AddressTypes', 'typeCode', array('alias' => 'type'));
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
}
