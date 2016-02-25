<?php

namespace App\Controllers;

/**
 * ErrorController 
 */
class ErrorController extends ControllerBase
{

    public function initialize()
    {
        $this->view->setTemplateBefore('blank');
        parent::initialize();
    }

    public function show404Action()
    {
        $this->tag->prependTitle('Woops!');
        $this->response->setStatusCode(404, 'Not Found');
        $this->view->pick('404/404');
    }

    public function permissionDeniedAction()
    {
        $this->tag->prependTitle('Woops!');
    }
    
}