<?php

namespace App\Controllers\Admin;

class OrdersController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Orders');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}