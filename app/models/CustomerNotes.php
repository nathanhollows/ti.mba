<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class CustomerNotes extends Model
{
    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var integer
     */
    public $customerCode;

    /**
     *
     * @var string
     */
    public $note;

	/**
     *
     * @var string
     */
	public $date;

    /**
     *
     * @var integer
     */
    public $user;

    public function initialize()
    {
    	$this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode');
    	$this->hasOne('user', 'App\Models\Users', 'id');
    }
}