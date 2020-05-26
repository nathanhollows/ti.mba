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
        $this->view->setViewsDir('/var/www/html/app/facelift/');
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
        $this->view->pick('error/404');
        $this->view->pageTitle = " ";
        $this->view->pageSubtitle = " ";
    }

    public function panicAction()
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('none');
            $response = new Response();
            $response->setStatusCode(501, 'Server error');
            $response->setContent('Server error');
            $response->send();
            return true;
        }
        $this->view->noHeader = true;
        $this->tag->prependTitle('Error | ');
        $this->response->setStatusCode(500, 'Server error');
        $this->view->pick('error/panic');
    }

    public function permissionDeniedAction()
    {
        $this->tag->prependTitle('Woops!');
    }
}
