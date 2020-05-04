<?php

namespace App\Controllers;

use App\Freight\Freight;
use App\Models\PbtConsignments;
use App\Models\Dockets;
use App\Mail\Mail;
use Phalcon\Mvc\View;
use Phalcon\Http\Response;

class FreightController extends ControllerBase
{

	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
		$this->view->setViewsDir('/var/www/html/app/facelift/');
	}

	public function indexAction()
	{
		$this->tag->prependTitle('Freight Following');

		$this->view->noHeader = true;

		$dockets = new Dockets();
		$this->view->outstanding = $dockets->tracking();

	}

	/**
	 * Function that looks up the reference and composes an email to cspalmerstonnorth@pbt.co.nz
	 * requesting an ETA on a job
	 */
	public function mailAction($carrier, $reference)
	{
		$response = new Response();
		$docket = Dockets::findFirstByconNote($reference);
		if(!$docket){
			$response->setStatusCode(404, "Not found");
			$response->setContent("This con note could not be found");
			return $response->send();
		}
		if(!$docket){
			$response->setStatusCode(501, "Already sent");
			$response->setContent("Cannot send an email twice");
			return $response->send();
		}
		$mail = new Mail();
		switch ($carrier) {
		case 'mainfreight':
			$email = 'PNHCustomerService@mainfreight.co.nz';
			break;
		case 'pbt':
			$email = 'cspalmerstonnorth@pbt.co.nz';
			break;
		default:
			break;
		}
		$success = $mail->send($email, "Update on $reference please", 'freight', array('conNote' => $reference));
		if ($success) {
			$response->setStatusCode(200, "Success");
			$response->setContent("The email was delivered");
			$docket->emailed = 1;
			$docket->save();
		} else {
			$response->setStatusCode(501, "Error");
			$response->setContent("Something went wrong");
		}
		$response->send();
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
