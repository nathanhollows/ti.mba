<?php

namespace App\Models;

use App\Models\Grade;
use Phalcon\Mvc\Model;

class PacketHistory extends Model
{

    /**
     * @var int
     * Indexed for faster sorting
     */
    public $id;

    /**
     * @var string MySQL TIMESTAMP/DATETIME represented as a string in PHP
     * Indexed for faster sorting
     */
    public $timestamp;

    /**
     * @var string
     */
    public $operation;

    /**
     * @var string
     * Indexed for faster sorting
     */
    public $packetNo;

    /**
     * @var string
     * Indexed for faster sorting
     */
    public $orderNo;

    /**
     * @var int
     */
    public $orderItem;

    /**
     * @var string Date represented as a string, format: 'Y-m-d'
     */
    public $date;

    /**
     * @var string Date represented as a string, format: 'Y-m-d'
     */
    public $dateIn;

    /**
     * @var string Date represented as a string, format: 'Y-m-d'
     */
    public $dateOut;

    /**
     * @var string
     */
    public $run;

    /**
     * @var string
     */
    public $grade;

    /**
     * @var string
     */
    public $treatment;

    /**
     * @var string
     */
    public $dryness;

    /**
     * @var string
     */
    public $finish;

    /**
     * @var int
     */
    public $width;

    /**
     * @var int
     */
    public $thickness;

    /**
     * @var int
     */
    public $finishWidth;

    /**
     * @var int
     */
    public $finishThickness;

    /**
     * @var float
     */
    public $length;

    /**
     * @var float
     */
    public $netCube;

    /**
     * @var float
     */
    public $cubeMovement;

    /**
     * @var float
     */
    public $linealTally;

    /**
     * @var float
     */
    public $cost;

    /**
     * @var int
     */
    public $piecesBalance;

    /**
     * @var int
     */
    public $piecesInOut;

    /**
     * @var float
     */
    public $linealMovement;

    /**
     * @var float
     */
    public $freightAllowance;

    /**
     * @var int
     */
    public $cocId;

    /**
     * @var string
     */
    public $pack;

    /**
     * @var string
     */
    public $comment;

    /**
     * @var int
     */
    public $previousPacketHistoryID;

    public function initialize()
    {
        $this->setSource('packet_history');
        $this->belongsTo('packetNo', '\App\Models\Stock', 'packet', ['alias' => 'packet']);
        $this->hasOne('grade', Grade::class, 'id', array('alias'  => 'grade'));
        $this->hasOne('treatment', 'App\Models\Treatment', 'id', array('alias'  => 'treatment'));
        $this->hasOne('dryness', 'App\Models\Dryness', 'id', array('alias'  => 'dryness'));
        $this->hasOne('finish', 'App\Models\Finish', 'id', array('alias'  => 'finish'));
    }
}
