<?php

namespace App\Models;

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

    public function tracking()
    {
        return parent::find(
            array(
                'conditions'    => '(carrier LIKE "%Mainfreight%" OR carrier LIKE "%Peter%") AND delivered = 0',
                'order'         => 'date ASC'
            )
        );
    }

    public function markDelivered()
    {
        $this->delivered = 1;
        $this->update();
    }
}
