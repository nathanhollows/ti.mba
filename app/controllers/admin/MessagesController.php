<?php

namespace App\Controllers\Admin;

class MessagesController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Messages');
        parent::initialize();
	}

    public function indexAction()
    {
    	echo '[' . __METHOD__ . ']';
    }
}