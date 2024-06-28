<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Trips extends Model
{
    /**
     *
     * @var int
     */
    public $id;

    /**
     *
     * @var string
     */
    public $name;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->hasMany('id', 'App\Models\TripStops', 'tripId', array('alias' => 'stops'));
    }
}
