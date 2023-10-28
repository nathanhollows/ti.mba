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

    public $finish;

    public $treatment;

    public $dryness;

    public $lengths;

    public $qty;

    public $priceUnit;

    public $price;

    public $lineValue;

    public function initialize()
    {
        $this->hasOne('priceMethod', 'App\Models\PricingUnit', 'id', array('alias'  => 'unit'));
        $this->hasOne('grade', 'App\Models\Grade', 'shortCode', array('alias'  => 'gra'));
        $this->hasOne('dryness', 'App\Models\Dryness', 'shortCode', array('alias'  => 'dry'));
        $this->hasOne('treatment', 'App\Models\Treatment', 'shortCode', array('alias'  => 'treat'));
        $this->hasOne('finish', 'App\Models\Finish', 'id', array('alias'  => 'fin'));
    }

    public function beforeSave()
    {
        if ($this->price == null) {
            $this->price = 0;
        }
        $this->lineValue = $this->price * $this->qty;
    }
}
