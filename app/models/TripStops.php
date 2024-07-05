<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class TripStops extends Model
{
    /**
     * An integer id, auto-incremented
     * @var int
     */
    public $id;

    /**
     * An integer id of the trip
     * @var int
     */
    public $tripId;

    /**
     * The ordering of the location
     * @var int
     */
    public $ordering;

    /**
     * The name of the location
     * @var string
     */
    public $customerCode;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->belongsTo('tripId', 'App\Models\Trips', 'id', array('alias'  => 'trip'));
        $this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
    }

    /**
     * Remove stops for a given trip
     * @param int $tripId
     */
    public static function removeStopsForTrip($tripId)
    {
        self::find([
            'conditions' => 'tripId = :tripId:',
            'bind' => [
                'tripId' => $tripId
            ]
        ])->delete();
    }
}
