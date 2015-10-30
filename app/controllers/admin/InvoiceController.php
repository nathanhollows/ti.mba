<?php

namespace App\Controllers\Admin;

class InvoiceController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Invoice');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}