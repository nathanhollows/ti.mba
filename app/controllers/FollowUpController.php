<?php

namespace App\Controllers;

use App\Forms\FollowUpForm;
use App\Forms\ReminderForm;
use App\Auth\Auth;
use App\Models\FollowUp;
use App\Models\ContactRecord;

class FollowupController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();
	}

	public function indexAction() {
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->view->pageTitle = "New Contact Record";
		$followUp = new FollowUp;
		$options = array();

		if (null !== ($this->request->getQuery('company'))) {
			$followUp->assign(array(
				'customerCode'	=> $this->request->getQuery('company')
				)
			);
			$options = array(
				'customerCode' => $this->request->getQuery('company')
			);
		}		

		if (null !== ($this->request->getQuery('contact'))) {
			$followUp->assign(array(
				'contact'	=> $this->request->getQuery('contact')
				)
			);
		}

		if (null !== ($this->request->getQuery('job'))) {
			$followUp->assign(array(
				'job'	=> $this->request->getQuery('job')
				)
			);
		}

		$this->view->form = new FollowUpForm($followUp, $options);

	}

	public function editAction($id) 
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->view->pageTitle = "Edit Contact Record";
		$followUp = ContactRecord::findFirstById($id);

		$options = array(
			"customerCode" => $followUp->customerCode,
			"followUpDate" => $followUp->followUpDate,
		);

		$this->view->form = new FollowUpForm($followUp, $options);
		$this->view->record = $followUp;

	}

	public function remindMeAction()
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->view->pageTitle = "Remind Me";
		$this->view->pageSubtitle = " ";
		$followUp = new FollowUp;

		if (null !== ($this->request->getQuery('company'))) {
			$followUp->assign(array(
				'customerCode'	=> $this->request->getQuery('company')
				)
			);
		}		

		if (null !== ($this->request->getQuery('contact'))) {
			$followUp->assign(array(
				'contact'	=> $this->request->getQuery('contact')
				)
			);
		}

		if (null !== ($this->request->getQuery('job'))) {
			$followUp->assign(array(
				'job'	=> $this->request->getQuery('job')
				)
			);
		}

		$this->view->form = new ReminderForm($followUp);
	}

	public function createAction()
	{
		// Disable the view. We're just processing information so this isn't needed.
		$this->view->disable();

		// Create a new record
		$contact = new ContactRecord();
		// Populate the record with the posted data
		$contact->customerCode = $this->request->getPost('customerCode');
		$contact->contact = $this->request->getPost('contact');
		$contact->job = $this->request->getPost('job');
		$contact->details = $this->request->getPost('details');
		$contact->contactType = $this->request->getPost('contactType');
		$contact->user = $this->request->getPost('user');
		$contact->contactType = $this->request->getPost('contactType');
		$contact->completed = 1;
		if ($this->request->getPost("remind")) {
			$contact->followUpDate = $this->request->getPost("followUpDate");
			$contact->followUpUser = $this->request->getPost("user");
			$contact->completed = 0;
		}
		// Store and check for errors
		$success = $contact->save();
		if ($success) {
			$this->flashSession->success("Contact history saved!");
			return $this->_redirectBack();
		} else {
			$this->flashSession->error("Sorry, the record could not be saved");
			foreach ($contact->getMessages() as $message) {
				$this->flashSession->error($message->getMessage());
			}
			return $this->_redirectBack();
		}
	}

	public function setReminderAction()
	{
		$this->view->disable();

		$followUp = new FollowUp();
		// Store and check for errors
		$followUp->date = date('Y-m-d');

		$auth = new Auth;

		$followUp->user = $auth->getId();
		
		$success = $followUp->save($this->request->getPost(), array('followUpDate', 'followUpUser', 'notes'));
		if ($success) {
			$this->flashSession->success("Reminder set!");
			return $this->_redirectBack();
		} else {
			$this->flashSession->error("Sorry, the reminder could not be saved");
			foreach ($followUp->getMessages() as $message) {
				$this->flashSession->error($message->getMessage());
			}
			return $this->_redirectBack();
		}
	}

	public function updateAction()
	{
		// echo "<pre>";
		// echo print_r($this->request->getPost());
		// echo "</pre>";
		// return false;

		$this->view->disable;
		if (!$this->request->isPost()) {
			return $this->dispatcher->forward(array(
				"controller" => "customers",
				"action" => "index"
				));
		}

		$history = ContactRecord::findFirstById($this->request->getPost('id'));
        // Store and check for errors
		$success = $history->save($this->request->getPost(), array('details', 'contact', 'job', 'company', 'date', 'user', 'contactType'));
		if ($success) {
			$this->flash->success("Quote created successfully!");
			return $this->_redirectBack();
		} else {
			$this->flash->error("Sorry, the quote could not be saved");
			foreach ($contact->getMessages() as $message) {
				$this->flash->error($message->getMessage());
			}
		}
	}

	public function completeAction($id = null)
	{
		$this->view->disable();

		$followUp = FollowUp::findFirstById($id);
		if (!$followUp) {
			$this->flashSession->error("That task could not be found");
			$this->_redirectBack();
		}

		$followUp->complete();
		$this->_redirectBack();
	}
}