<?php

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

    public function route404Action()
    {
    	$this->view->hello = 'Hi!';
    	echo "hello!";
    }
}
