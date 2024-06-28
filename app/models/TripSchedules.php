<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class TripSchedules extends Model
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
     * Start date of the trip
     * @var string
     */
    public $startDate;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->belongsTo('tripId', 'App\Models\Trips', 'id', array('alias'  => 'trip'));
    }
}
