<?php

namespace App\Models;

class PacketTally extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     */
    public $packetNumber;

    /**
     *
     * @var integer
     */
    public $quantity;

    /**
     *
     * @var double
     */
    public $length;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'packet_tally';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return PacketTally[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return PacketTally
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return array(
            'packetNumber' => 'packetNumber',
            'quantity' => 'quantity',
            'length' => 'length'
        );
    }

}
