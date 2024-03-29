<?php

namespace App\Controllers;

use App\Forms\FollowUpForm;
use App\Forms\ReminderForm;
use App\Plugins\Auth\Auth;
use App\Models\FollowUp;
use App\Models\ContactRecord;
use App\Models\Quotes;
use Phalcon\Http\Response;

class FollowupController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $followUp = new FollowUp;
        $options = array();

        if (null !== ($this->request->getQuery('company'))) {
            $followUp->assign(
                array(
                'customerCode'	=> $this->request->getQuery('company')
                )
            );
            $options = array(
                'customerCode' => $this->request->getQuery('company')
            );
        }

        if (null !== ($this->request->getQuery('contact'))) {
            $followUp->assign(
                array(
                'contact'	=> $this->request->getQuery('contact')
                )
            );
        }

        if ($this->request->getQuery('job') !== null) {
            $quote = Quotes::findFirst($this->request->getQuery('job'));
            $followUp->reference = $quote->reference;
            $followUp->assign([
                'job'	=> $this->request->getQuery('job'),
                'customerCode' => $quote->customerCode,
                'contact' => $quote->contact,
            ]);
        }

        $this->view->form = new FollowUpForm($followUp, $options);
    }

    public function editAction($id)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $followUp = ContactRecord::findFirstById($id);
        $followUp->date = date("Y-m-d", strtotime($followUp->date));
        $this->view->details = $followUp;

        $options = array(
            "customerCode" => $followUp->customerCode,
            "followUpDate" => $followUp->followUpDate,
        );

        $this->view->form = new FollowUpForm($followUp, $options);
        $this->view->record = $followUp;
    }

    public function deleteAction($id = null)
    {
        $this->view->disable();
        $record = ContactRecord::findFirstById($id);

        if (!$record) {
            $this->flashSession->error('This record could not be found');
            $this->_redirectBack();
        }

        if ($record->delete()) {
            $this->flashSession->success('Record deleted');
            $this->_redirectBack();
        } else {
            $this->flashSession->error('This record could not be deleted');
            $this->_redirectBack();
        }
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
            $followUp->assign(
                array(
                'customerCode'	=> $this->request->getQuery('company')
                )
            );
        }

        if (null !== ($this->request->getQuery('contact'))) {
            $followUp->assign(
                array(
                'contact'	=> $this->request->getQuery('contact'),
                )
            );
        }

        if (null !== ($this->request->getQuery('job'))) {
            $followUp->assign(
                array(
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
        $contact->customerCode 		= $this->request->getPost('customerCode');
        $contact->contact 			= $this->request->getPost('contact');
        if (empty($this->request->getPost('contact'))) {
            $contact->contact = null;
        }
        $contact->job 				= $this->request->getPost('job');
        if (empty($this->request->getPost('job'))) {
            $contact->job = null;
        }

        $contact->details 			= $this->request->getPost('details');
        $contact->date             = date("Y-m-d H:i:s", strtotime($this->request->getPost('recordDate')));
        $contact->contactType 		= $this->request->getPost('contactType');
        $contact->user = $this->auth->getId();
        $contact->contactType 		= $this->request->getPost('contactType');
        $contact->reference 		= $this->request->getPost('reference');

        if ($this->request->getPost("remind")) {
            $contact->followUpDate = $this->request->getPost("followUpDate");
            $contact->completed = null;
        }
        if ($contact->save()) {
            $this->flashSession->success("Contact record saved!");
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

        $followUp->assign($this->request->getPost(), array('followUpDate', 'followUpUser', 'notes'));
        if ($followUp->save()) {
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
        $this->view->disable;
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
                ));
        }

        $record = ContactRecord::findFirstById($this->request->getPost('id'));

        if ($record->completed == null and !$this->request->getPost('remind')) {
            $record->completed = date("Y-m-d H:i:s");
        }

        // If there is a reminder set the make sure this is recorded
        if ($this->request->getPost('remind')) {
            $record->completed = null;
        }
        $record->contact 			= $this->request->getPost('contact');
        if (empty($this->request->getPost('contact'))) {
            $record->contact = null;
        }
        $record->job 				= $this->request->getPost('job');
        if (empty($this->request->getPost('job'))) {
            $record->job = null;
        }

        // Store and check for errors
        $record->assign($this->request->getPost(), array('customerCode','details','reference', 'company', 'date', 'user', 'contactType','followUpDate'));
        if ($record->update()) {
            $this->flashSession->success("Contact record updated");
            return $this->_redirectBack();
        } else {
            $this->flash->error("Sorry, the contact record could not be updated");
            foreach ($record->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function completeAction($id = null)
    {
        $this->view->disable();

        $followUp = ContactRecord::findFirstById($id);
        if (!$followUp) {
            $this->flashSession->error("That task could not be found");
            $this->_redirectBack();
        }

        $followUp->completed = date("Y-m-d H:i:s");
        if ($followUp->save()) {
            $this->flashSession->success("Task completed");
        }

        $this->_redirectBack();
    }

    public function ajaxcompleteAction($id = null)
    {
        // Disable the view
        $this->view->disable();
        // Check if the request was made with AJAX
        if (!$this->request->isAjax()) {
            $this->flashSession->error("Woops, something went wrong.");
            return $this->_redirectBack();
        }

        if (!$id) {
            $id = $this->request->getPost('pk');
        }

        // Find the first matching record
        $record = ContactRecord::findFirstById($id);

        $response = new Response();

        if (!$record) {
            $response->setStatusCode(404, "Contact Record '". $id ."' not found");
            return $response;
        }

        $record->completed = date("Y-m-d H:i:s");
        if ($record->save()) {
            $response->setStatusCode(200, "Updated successfully");
            return $response;
        } else {
            $response->setStatusCode(500, "Something went wrong");
            return $response;
        }
    }

    public function ajaxupdateAction()
    {
        if (!$this->request->isAjax()) {
            $this->flashSession->error("Woops, something went wrong.");
            return $this->_redirectBack();
        }

        $this->view->disable();

        $response = new Response();

        $record = ContactRecord::findFirstById($this->request->getPost('pk'));
        if (!$record) {
            $response->setStatusCode(404, 'Contact Record not found');
            $response->send();
            return true;
        }

        $record->details = $this->request->getPost('value');
        $success = $record->save();
        if ($success) {
            $response->setStatusCode(200, 'Update successfully');
            return $response;
        } else {
            $response->setStatusCode(501, 'Something went wrong');
            return $response;
        }

        $response->setStatusCode(501, 'Something went wrong');
        return $response;
    }

    public function newdateAction()
    {
        if (!$this->request->isAjax()) {
            $this->flashSession->error("Woops, something went wrong.");
            return $this->_redirectBack();
        }

        $this->view->disable();

        $response = new Response();

        $record = ContactRecord::findFirstById($this->request->getPost('pk'));
        if (!$record) {
            $response->setStatusCode(404, 'Contact Record not found');
            return $response;
        }

        $record->followUpDate = date("Y-m-d", strtotime($this->request->getPost('value')));
        $success = $record->save();
        if ($success) {
            $response->setStatusCode(200, 'Update successfully');
            return $response;
        } else {
            $response->setStatusCode(501, 'Something went wrong');
            return $response;
        }

        $response->setStatusCode(501, 'Something went wrong');
        return $response;
    }
}
