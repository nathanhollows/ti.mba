<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class PacketHistory extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $date;

    /**
     *
     * @var string
     */
    public $packetNumber;

    /**
     *
     * @var string
     */
    public $comment;

    /**
     *
     * @var string
     */
    public $operation;

    /**
     *
     * @var string
     */
    public $location;

    /**
     *
     * @var integer
     */
    public $width;

    /**
     *
     * @var integer
     */
    public $thickness;

    /**
     *
     * @var integer
     */
    public $finWidth;

    /**
     *
     * @var integer
     */
    public $finThickness;

    /**
     *
     * @var string
     */
    public $grade;

    /**
     *
     * @var string
     */
    public $treatment;

    /**
     *
     * @var string
     */
    public $dryness;

    /**
     *
     * @var string
     */
    public $finish;

    public function initialize()
    {
        $this->setSource('packet_history');
        $this->belongsTo('packetNumber', '\App\Models\Packets', 'packet', ['alias' => 'packet']);
        $this->hasOne('grade', 'App\Models\Grade', 'id', array('alias'  => 'grade'));
        $this->hasOne('treatment', 'App\Models\Treatment', 'id', array('alias'  => 'treatment'));
        $this->hasOne('dryness', 'App\Models\Dryness', 'id', array('alias'  => 'dryness'));
        $this->hasOne('finish', 'App\Models\Finish', 'id', array('alias'  => 'finish'));
    }
}
