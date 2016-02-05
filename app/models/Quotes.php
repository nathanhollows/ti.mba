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

	public $user;

	public $contact;

	public function initialize()
	{
		$this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
		$this->hasOne('contact', 'App\Models\Contacts', 'id', array('alias' => 'customerContact'));
		$this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'salesRep'));
	}
}