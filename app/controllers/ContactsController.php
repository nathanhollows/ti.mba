<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Forms;
use App\Models\Contacts;
use App\Models\ContactRecord;
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

	public function viewAction($id = null)
	{
		$this->view->parser = new \cebe\markdown\Markdown();
		$contact = Contacts::findFirst("id = '$id'");

		if (!$contact) {
			$this->flash->error("Woops! There is no contact with that ID");
			return $this->dispatcher->forward(array(
				"controller"	=> "contacts",
				"action"		=> ""
			));
		}

		$history = ContactRecord::find(array(
            "contact = '$id'",
            'order'         => 'id DESC',
            'limit'         => 8
        ));
        $this->view->history = $history;
		
        $this->view->headerButton = \Phalcon\Tag::linkTo(array("followup/?company=" . $contact->customerCode . "&contact=" . $id, '<i class="fa fa-plus"></i> Add Record', "class" => "btn btn-default pull-right", "data-target" => "#modal-ajax"));

		$this->view->history = $history;

		$this->view->contact = $contact;

		// Set page titles
		$this->view->pageTitle = $contact->name;
		$this->tag->prependTitle($contact->name);
		$this->view->pageSubtitle = " ";
		if ($contact->company <> null) {
			$this->view->pageSubtitle = $contact->company->customerName;
		}
	}

	public function newAction($customerCode = null)
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->tag->prependTitle("Create a Contact");

		$profile = new Contacts();
		$profile->assign(array(
			'customerCode'	=> $customerCode
		));
		
		$this->view->pageTitle = "Create new Contact";
		$this->view->form = new ContactsForm($profile, array(
			'edit' => true
		));
	}

	public function editAction($id = null)
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		if (!isset($id)) {
			$this->flash->error("Malformed URL");
            return $this->dispatcher->forward(array(
                "controller" => "contacts",
                "action" => "index"
            ));
		}


		$this->view->pageTitle = 'Edit';

		$contact = Contacts::findFirstById($id);

		$form = new ContactsForm($contact);
		$this->view->form = $form;
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
        $success = $contact->save($this->request->getPost(), array('customerCode', 'name', 'email', 'directDial', 'position'));
		if ($success) {
			$this->response->redirect('contacts/view/' . $contact->id);
			$this->view->disable;
		} else {
			$this->flash->error("Sorry, the quote could not be saved");
			foreach ($contact->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}

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