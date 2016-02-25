<?php

namespace App\Controllers;

use App\Forms\FollowUpForm;
use App\Models\FollowUp;
use App\Models\ContactRecord;

class FollowUpController extends ControllerBase
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

		$this->view->form = new FollowUpForm($followUp);

	}

	public function editAction($id) 
	{
		if ($this->request->isAjax()) {
			$this->view->setTemplateBefore('modal-form');
		}

		$this->view->pageTitle = "Edit Contact Record";
		$followUp = ContactRecord::findFirstById($id);

		$this->view->form = new FollowUpForm($followUp);

	}

	public function createAction()
	{
		$this->view->disable();

		$contact = new ContactRecord();
		// Store and check for errors
		$success = $contact->save($this->request->getPost(), array('customerCode', 'contact', 'job', 'details', 'contactType', 'user', 'date'));
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

	public function updateAction()
	{

        $this->view->disable;
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
                ));
        }

        $history = ContactRecord::findFirstById($this->request->getPost('id'));
        // Store and check for errors
        $success = $history->save($this->request->getPost(), array('details', 'contact', 'job', 'company', 'date', 'user',));
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
}