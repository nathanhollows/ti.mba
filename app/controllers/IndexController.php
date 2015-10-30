<?php

namespace App\Controllers;

use Phalcon\Tag;

class IndexController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Home');
        parent::initialize();
	}

    public function indexAction()
    {

    }
}
