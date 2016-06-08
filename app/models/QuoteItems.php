<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class QuoteItems extends Model
{
	public $id;

	public $quoteId;

	public $grade;

	public $finish;

	public $width;

	public $thickness;

	public $callSize;

	public $finSize;

	public $lengths;

	public $qty;

	public $priceUnit;

	public $unitPrice;

	public function initialize()
	{
		$this->hasOne('priceUnit', 'App\Models\PricingUnit', 'id', array('alias'  => 'unit'));
		// Layer of compatiblity for migration
		$this->hasOne('grade', 'App\Models\QuoteCodes', 'code', array('alias'  => 'legacy'));
		$this->hasOne('finish', 'App\Models\Finish', 'id', array('alias'  => 'fin'));
	}

}