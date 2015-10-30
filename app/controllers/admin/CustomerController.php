<?php

namespace App\Controllers\Admin;

class CustomerController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Customers');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}