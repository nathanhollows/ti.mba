<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Customers extends Model {
	
	public $customerId;

	public $customerName;

	public $freightArea;

	public $customerPhone;

	public $customerFax;

	public $customerEmail;

	public $orderNotes;

	public $dispatchNotes;

	public $groupId;

	public $customerGroup;

	public $salesArea;

	public function initialize()
	{
		$this->belongsTo('customerGroup', 'CustomerGroups', 'id', array(
			'reusable'	=> true,
		));
	}

}