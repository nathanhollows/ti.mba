<?php

namespace App\Controllers\Admin;

class ReportsController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Reports');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}