<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class QuoteItems extends Model
{
	public $id;

	public $quoteId;

	public $grade;

	public $finish;

	public $callSize;

	public $finSize;

	public $lengths;

	public $qty;

	public $priceUnit;

	public $unitPrice;

	public function initialize()
	{
		$this->hasOne('priceUnit', 'App\Models\PricingUnit', 'id', array('alias'  => 'unit'));
	}
}