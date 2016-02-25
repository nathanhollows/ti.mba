<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Validator\Uniqueness;

class PbtConsignments extends Model
{

	public $customerConsignment;

	public $pbtConsignmentNote;
	
	public $numberOfItems;
	
	public $weight;
	
	public $pickupDate;
	
	public $podDate;
	
	public $podTime;
	
	public $deliveryBy;
	
	public $podSignature;
	
	public $deliveryCourier;
	
	public $ticketNo;
	
	public $cost;
	
	public $runsheet;
	
	public $accountNo;
	
	public $volume;

	public function validation()
	{

		$this->validate(
			new Uniqueness(
				array(
					"field"   => "pbtConsignmentNote",
					"message" => "Skipping duplicate entry " . $this->customerConsignment,
					)
				)
			);

		return $this->validationHasFailed() != true;
	}
	
}