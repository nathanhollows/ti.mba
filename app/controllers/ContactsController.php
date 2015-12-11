<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Form;
use App\Models\Contacts;

class ContactsController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction()
	{
		
	}

	public function viewAction($contact)
	{
		$contactDetails = Contacts::findFirst("id = $contact");
		$this->view->contactDetails = $contactDetails;
		$this->view->pageTitle = $contactDetails->firstName . " " . $contactDetails->lastName;
		$this->view->pageSubtitle = $contactDetails->customers->customerName;
	}
}