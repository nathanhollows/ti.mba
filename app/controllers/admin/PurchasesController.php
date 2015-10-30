<?php

namespace App\Controllers\Admin;

class PurchasesController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Purchases');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}