<?php

namespace App\Controllers;

use App\Auth\Auth;
use Phalcon\Http\Response;

/**
 * ErrorController
 */
class ErrorController extends ControllerBase
{

    public function initialize()
    {
        $auth = new Auth;

        if ($auth->getId()) {
            $this->view->setTemplateBefore('private');
        } else {
            $this->view->setTemplateBefore('blank');
        }
        parent::initialize();
    }

    public function show404Action()
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('none');
            $response = new Response();
            $response->setStatusCode(404, "Route does not exist");
            $response->setContent("Route does not exist");
            $response->send();
            return true;
        }
        $this->view->noHeader = true;
        $this->tag->prependTitle('Error 404');
        $this->response->setStatusCode(404, 'Not Found');
        $this->view->pick('404/404');
        $this->view->pageTitle = " ";
        $this->view->pageSubtitle = " ";
    }

    public function permissionDeniedAction()
    {
        $this->tag->prependTitle('Woops!');
    }

}
