<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Models\ContactRecord;
use App\Auth\Auth;

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

    public function afterCreate()
    {
        $auth = new Auth;
        // Lets make some history
        $history = new ContactRecord();
        $history->date = date('Y-m-d');
        $history->customerCode = $this->customerCode;
        $history->user = $auth->getId();
        $history->contactType = 13;
        $history->contact = $this->id;
        $history->details = "Quote " . $this->quoteId . " created by " . $auth->getName();
        $history->save();
    }

    public function getHot()
    {
		$results = parent::find(array(
			"status = 1",
		));
		return $results;
    }

    public function getWarm()
    {
		$results = parent::find(array(
			"status = 2",
		));
		return $results;
    }

    public function getCold()
    {
		$results = parent::find(array(
			"status = 3",
		));
		return $results;
    }

    public function getDead()
    {
		$results = parent::find(array(
			"status = 4",
		));
		return $results;

    }

}