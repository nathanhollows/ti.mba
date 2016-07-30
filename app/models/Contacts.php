<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Models\ContactRecord;
use App\Auth\Auth;

class Contacts extends Model
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
     *
    * @var int
    */
    public $role;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
        $this->hasMany('id', 'App\Models\ContactRecords', array('alias' => 'history'));
        $this->hasOne('role', 'App\Models\ContactRoles', 'id', array('alias'  => 'job'));
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
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'contacts';
    }

}
