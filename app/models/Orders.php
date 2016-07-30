<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Orders extends Model
{
	public $orderNumber;

	public $customerRef;
	
	public $date;
	
	public $quoted;
	
	public $complete;
	
	public $description;
	
	public $cancelled;

	public $checked;

	public function initialize()
	{
		$this->keepSnapshots(true);
		$this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
		$this->hasMany('orderNumber', 'App\Models\OrderItems', 'orderNo', array('alias'	=> 'items'));
		$this->hasOne('location', 'App\Models\OrderLocations', 'id', array('alias'	=> 'whereabouts'));

	}

	public function beforeUpdate()
	{
		if ($this->hasChanged('eta')) {
			$this->checked = date("Y-m-d H:i:s");
			$this->followUp = 0;
		}
	}

	public static function scheduled() 
	{
		return parent::find(
			array(
				"scheduled = 1 AND complete = 0",
				"order"	=> "customerCode ASC"
			)
		);
	}

}