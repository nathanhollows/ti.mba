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
        $this->hasMany(array('orderNo', 'itemNo'), 'App\Models\OrderTallies', array('orderNumber', 'itemNumber'), array('alias' => 'tallies'));
        $this->hasOne('grade', 'App\Models\Grade', 'shortCode', ['alias' => 'Grade']);
        $this->hasOne('treatment', 'App\Models\Treatment', 'shortCode', ['alias' => 'Treatment']);
        $this->hasOne('dryness', 'App\Models\Dryness', 'shortCode', ['alias' => 'Dryness']);
        $this->hasOne('finish', 'App\Models\Finish', 'shortCode', ['alias' => 'Finish']);
    }

    public static function scheduled()
    {
        return parent::find(
            array(
                "columns" => array(
                    "SUM( width * thickness * (ordered - sent) / 1000000) as cube",
                    "SUM( price * (ordered - sent)) as value",
                ),
                "conditions" => "despatch = 1 AND complete = 0",
            )
        );
    }
}
