<?php

namespace App\Controllers;

use App\Models\Feedback;
use Phalcon\Http\Response;

class FeedbackController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        // Check if developer
        if ($this->auth->getUser()->developer != 1) {
            $this->flashSession->warning("You are not allowed to view this page.");
            $this->response->redirect("dashboard");
            return;
        }

        $this->tag->prependTitle("Feedback");
        $this->view->feedback = Feedback::find([
            "order" => "time DESC"
        ]);
    }

    public function newAction()
    {
        $feedback = new Feedback();

        $feedback->uri = $this->request->get("uri");
        $feedback->user = $this->auth->getId();

        if ($this->request->hasPost("opinion")) {
            $feedback->opinion = $this->request->getPost("opinion");
        }

        $feedback->feedback = $this->request->getPost("feedback");

        if (!$feedback->save()) {
            $response = new Response();
            foreach ($feedback->getMessages() as $message) {
                $response->setContent($message);
            }
            $response->setStatusCode(400, "Something went wrong");
            $response->send();
            return;
        } else {
            $response = new Response();
            $response->setStatusCode(200, "Okay");
            $response->send();
        }
    }
}
