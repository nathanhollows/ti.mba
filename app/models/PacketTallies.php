<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class PacketTallies extends Model
{
    /**
     *
     * @var string
     */
    public $packetNo;

    /**
     * length
     * @var float
     */
    public $length;

    /**
     * count
     * @var integer
     */
    public $count;

    public function initialize()
    {
        $this->hasOne('packetNo', 'App\Models\Stock', 'packetNo', array('alias'  => 'packet'));
    }
}
