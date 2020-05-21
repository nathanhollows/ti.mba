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
        $this->belongsTo('typeCode', 'App\Models\Addresses', 'typeCode');
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

}
