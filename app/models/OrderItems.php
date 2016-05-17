<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Manager;

class OrderItems extends Model
{
	public $grade;
	
	public $teatment;
	
	public $dryness;
	
	public $finish;
	
	public $width;
	
	public $thickness;
	
	public $length;
	
	public $dry;
	
	public $customerCode;
	
	public $orderNo;
	
	public $itemNo;
	
	public $requiredBy;
	
	public $ordered;
	
	public $sent;
	
	public $outstanding;
	
	public $unit;
	
	public $despatch;
	
	public $comments;
	
	public $orderStock;
	
	public $notes;
	
	public $despatchNotes;
	
	public $location;

	public function initialize()
	{

		if ($despatch = -1) {
			$despatch = false;
		}

	}

}