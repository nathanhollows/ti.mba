<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Packets extends Model
{
    /**
     *
     * @var string
     */
    public $packetNumber;

    /**
     * createdId
     * @var integer
     */
    public $createdId;

    /**
     * lastId
     * @var integer
     */
    public $lastId;

    /**
     *
     * @var integer
     */
    public $location;

    /**
     *
     * @var integer
     */
    public $order_no;

    /**
     *
     * @var boolean
     */
    public $current;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->setSource('packets');
        $this->hasMany('packetNumber', 'App\Models\PacketTallies', 'packetNumber', array('alias'  => 'tallies'));
        $this->hasOne('createdId', 'App\Models\PacketHistory', 'id', array('alias'  => 'created'));
        $this->hasOne('lastId', 'App\Models\PacketHistory', 'id', array('alias'  => 'lastRecord'));
        $this->hasMany('packetNumber', 'App\Models\PacketHistory', 'packetNumber', array('alias'  => 'history'));
    }

    /**
     * Get all current packets
     * @return App\Models\Packets
     */
    public function getCurrent()
    {
        return self::find([
            'conditions'    => 'current = 1'
        ]);
    }
}
