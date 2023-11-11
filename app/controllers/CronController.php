<?php

namespace App\Controllers;

use App\Plugins\Freight\Freight;
use Phalcon\Mvc\Controller;


class CronController extends Controller
{

    public function initialize()
    {
        $this->view->disable();
        // If the request Client Address is not local then exit
        if ($this->request->getClientAddress() != '127.0.0.1') {
            exit;
        }
    }

    public function freightAction()
    {
        $freight = new Freight();
        $freight->trackMainfreight();
    }
}
