<?php

namespace App\Controllers;

/**
 * ErrorController 
 */
class ErrorController extends ControllerBase
{

	protected function initialize()
	{
        $this->tag->setTitle('Page Not Found');
        parent::initialize();
	}

    public function show404Action()
    {
        $this->response->setStatusCode(404, 'Not Found');
        $this->view->pick('404/404');
    }
}