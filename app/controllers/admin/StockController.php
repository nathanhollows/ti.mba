<?php

namespace App\Controllers\Admin;

class StockController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Stock');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}