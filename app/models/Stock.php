<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Stock extends Model
{
    /**
     *
     * @var string
     */
    public $packetNo;

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
        $this->hasMany('packetNo', 'App\Models\PacketTallies', 'packetNo', array('alias'  => 'tallies'));
        $this->hasOne('createdId', 'App\Models\PacketHistory', 'id', array('alias'  => 'created'));
        $this->hasOne('lastId', 'App\Models\PacketHistory', 'id', array('alias'  => 'lastRecord'));
        $this->hasMany('packetNo', 'App\Models\PacketHistory', 'packetNo', array('alias'  => 'history'));
    }

    /**
     * Get all current packets
     * @return App\Models\Stock
     */
    public function getCurrent()
    {
        return self::find([
            'conditions'    => 'current = 1'
        ]);
    }
}
