<?php

namespace App\Controllers;

use App\Models\Feedback;
use Phalcon\Http\Response;

class FeedbackController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('none');
		parent::initialize();
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
		} else {
			$response = new Response();
			$response->setStatusCode(200, "Okay");
			$response->send();
		}
	}

}
