<?php

namespace App\Controllers\Admin;

class DispatchController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Dispatches');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}