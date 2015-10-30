<?php

namespace App\Controllers;

use Phalcon\Tag;

class AboutController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('About');
        parent::initialize();
	}

    public function indexAction()
    {

    }
}
