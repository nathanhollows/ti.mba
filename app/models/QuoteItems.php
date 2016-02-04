<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class QuoteItems extends Model
{
	public $id;

	public $quoteId;

	public $width;

	public $thickness;

	public $grade;

	public $treatment;

	public $dryness;

	public $finish;

	public $price;

	public $priceMethod;

	public $linealTotal;
}