<?php

namespace App\Controllers\Admin;

class SettingsController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Settings');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}