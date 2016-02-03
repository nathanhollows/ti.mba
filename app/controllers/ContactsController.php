<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Forms;
use App\Models\Contacts;
use App\Forms\ContactsForm;

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
		$this->view->pageTitle = $contactDetails->name;
		$this->view->pageSubtitle = $contactDetails->customers->customerName;
	}

	public function newAction()
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('blank');
		}
		$this->view->pageTitle = "Create new Contact";
		$this->view->form = new ContactsForm;
	}

	public function createAction()
	{
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        $contact = new Contacts();
	}

	public function deleteAction($id)
	{
		$contact = Contacts::findFirstById($id);
		if (!$contact) {
			$this->flash->error("Contact was not found");

			return $this->dispatcher->forward(array(
				"controller"	=> "contacts",
				"action"		=> "index"
			));
		}

		if (!$contact->delete()) {

			foreach ($contact->getMessages() as $message) {
				$this->flash->error($message);
			}

			return $this->dispatcher->forward(array(
				"controller"	=> "contacts",
				"action"		=> "index"
			));
		}

		$this->flash->success("Contact was deleted successfully");

		return $this->dispatcher->forward(array(
			"controller"	=> "contacts",
			"action"		=> "index"
		));
	}
}