<?php

namespace App\Controllers\Mobile;

use App\Models\Orders;

class OrdersController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Orders');
        $this->view->pageTitle = "Scheduled Orders";

        $this->view->orders = Orders::getScheduled();
    }
}
