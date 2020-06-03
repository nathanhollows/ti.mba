<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class PacketTallies extends Model
{
    /**
     *
     * @var string
     */
    public $packetNumber;

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
        $this->hasOne('packetNumber', 'App\Models\Packets', 'packetNumber', array('alias'  => 'packet'));
    }
}
