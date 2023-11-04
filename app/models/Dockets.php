<?php

namespace App\Models;

use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Mvc\Model;

class Dockets extends Model
{

    /**
     *
     * @var integer
     */
    public $docketNo;

    /**
     *
     * @var integer
     */
    public $orderNo;

    /**
     *
     * @var string
     */
    public $date;

    /**
     *
     * @var string
     */
    public $conNote;

    /**
     *
     * @var string
     */
    public $carrierLabel;

    /**
     *
     * @var bool
     */
    public $delivered;

    /**
     *
     * @var bool
     */
    public $emailed;

    public function initialize()
    {
        $this->hasOne('orderNo', 'App\Models\Orders', 'orderNumber', array('alias'  => 'order'));
        $this->hasOne('carrierID', 'App\Models\FreightCarriers', 'id', array('alias'  => 'carrier'));
    }


    public function notDelivered()
    {
        return parent::find(
            array(
                'conditions' => 'delivered = 0',
                'order'      => 'date ASC',
            )
        );
    }

    public static function tracking()
    {
        $carriers = FreightCarriers::find([
            'columns'    => 'id',
            'conditions' => 'name LIKE "%Mainfreight%" OR name LIKE "%Peter%"'
        ]);
        foreach ($carriers as $carrier) {
            $carrierIds[] = $carrier->id;
        }
        return parent::find(
            array(
                'conditions' => 'delivered = 0 AND carrierID IN (' . implode(',', $carrierIds) . ')',
                'order'      => 'date ASC',
            )
        );
    }

    public function markDelivered()
    {
        $this->delivered = 1;
        $this->update();
    }
}
