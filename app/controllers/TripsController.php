<?php

namespace App\Controllers;

use App\Models\Customers;
use App\Models\SalesAreas;
use App\Models\Trips;
use App\Models\TripStops;

class TripsController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }
}
