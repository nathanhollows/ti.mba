<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Validator\Uniqueness;

class PbtConsignments extends Model
{

	public $customerConsignment;

	public $pbtConsignmentNote;

	public $numberOfItems;

	public $weight;

	public $pickupDate;

	public $podDate;

	public $podTime;

	public $deliveryBy;

	public $podSignature;

	public $deliveryCourier;

	public $ticketNo;

	public $cost;

	public $runsheet;

	public $accountNo;

	public $volume;

    public static function averageLast($date = null)
    {
        if(is_null($date)) {
            return false;
        }

        return parent::find(
            array(
                'columns' => array('1', 'avg' => 'AVG(dateDiff)'),
                'conditions'   => 'podDate > ?1',
                'group' => '1',
                'bind' => array(
                    1 => $date,
                ),
            )
        );

    }

}
