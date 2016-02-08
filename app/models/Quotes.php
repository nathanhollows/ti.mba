<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Quotes extends Model
{
	public $id;

	public $webId;

	public $date;

	public $customerCode;

	public $customerRef;

	public $details;

	public $user;

	public $contact;

	public $status;

	public function initialize()
	{
		$this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
		$this->hasOne('contact', 'App\Models\Contacts', 'id', array('alias' => 'customerContact'));
		$this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'salesRep'));
		$this->hasOne('status', 'App\Models\GenericStatus', 'id', array('alias' => 'genericStatus'));
	}
}