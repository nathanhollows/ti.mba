<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Quotes extends Model
{
	public $id;

	public $date;

	public $customerCode;

	public $user;

	public $attention;

	public $notes;

	public $moreNotes;

	public $reference;

	public $status;

	public $validity;

	public $sale;

	public $freight;

	public $directDial;

	public $leadTime;

	public function initialize()
	{
		$this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
		$this->hasOne('contact', 'App\Models\Contacts', 'id', array('alias' => 'customerContact'));
		$this->hasOne('user', 'App\Models\Users', 'id', array('alias' => 'rep'));
		$this->hasOne('status', 'App\Models\GenericStatus', 'id', array('alias' => 'genericStatus'));
	}

	public static function presented(){
		return parent::count("MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())");
	}

	public static function won()
	{
		$results = parent::count("MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW()) AND sale = 1");
		return count($results);
	}
	
}