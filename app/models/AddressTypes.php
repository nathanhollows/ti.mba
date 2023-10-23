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

}
