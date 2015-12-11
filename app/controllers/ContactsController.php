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
		$personnel = Contacts::find("id = '$contact'");
		$this->view->contactDetails = $personnel;
	}
}