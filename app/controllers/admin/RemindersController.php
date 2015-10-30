<?php

namespace App\Controllers\Admin;

class RemindersController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Reminders');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}