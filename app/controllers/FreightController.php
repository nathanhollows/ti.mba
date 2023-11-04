<?php

namespace App\Controllers;

use App\Models\Dockets;
use App\Mail\Mail;
use Phalcon\Http\Response;

class FreightController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Freight Tracker');

        $dockets = new Dockets();
        $this->view->outstanding = $dockets->tracking();

    }

    public function updateAction()
    {
        $this->view->disable();
        if (!$this->request->isAjax()) {
            $this->flashSession()->error("Error: disabled link");
            return $this->_redirectBack();
        }

        $response = new Response();

        $freight = Dockets::findFirstBydocketNo($this->request->getPost('id'));
        if (!$freight) {
            $response->setStatusCode(404, "Not Found");
            $response->setContent("Sorry, the docket couldn't be found");
            $response->send();
        }

        $success = $freight->markDelivered();

        if (!$success) {
            $response->setStatusCode(200, "Marked as delivered");
            $response->setContent("This was marked as delivered");
            $response->send();
        } else {
            $response->setStatusCode(501, "Something went wrong");
            $error = "Something went wrong";
            foreach ($success->getMessages() as $message) {
                $error = $error . " " . $message->getMessage();
            }
            $response->setContent($error);
            $response->send();
        }
    }

}