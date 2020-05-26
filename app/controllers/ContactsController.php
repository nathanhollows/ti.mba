<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Forms;
use App\Models\Contacts;
use App\Models\ContactRecord;
use App\Forms\ContactsForm;
use Phalcon\Security\Random;
use \Phalcon\Http\Response;

// TODO: Make URLS dynamic

class ContactsController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->view->headerButton = \Phalcon\Tag::linkTo(array('contacts/new', 'New', 'class' => ' btn btn-default pull-right'));

        $this->view->contacts = Contacts::find();
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

        $this->view->headerButton = '
        <!-- Split button -->
        <div class="btn-group pull-right">
            <a class="btn btn-default" data-target="#modal-ajax" href="/followup/?company=' . $contact->customerCode . '" role="button"><i class="fa fa-icon fa-pencil"></i> Add Record</a>
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <ul class="dropdown-menu">
            	<li><a href="#" data-href="/contacts/delete/' . $contact->id . '" data-toggle="modal" data-target="#confirm-delete">Delete</a></li>
            </ul>
        </div>
        ';

        $this->view->contact = $contact;

        // Set page titles
        $this->view->pageTitle = '<i class="fa fa-user" aria-hidden="true"></i> ' . $contact->name;
        $this->tag->prependTitle($contact->name);
        $this->view->pageSubtitle = " ";
        $this->view->pageSubheader = array(
            1 => array(
                'text' => $contact->company->customerName,
                'icon' => 'building',
                'link' => '/customers/view/' . $contact->company->customerCode,
            ),
        );
        $this->assets->collection('header')
            ->addCss('css/bootstrap-markdown.min.css', true);
        $this->assets->collection('footer')
            ->addJs('js/to-markdown.js', true)
            ->addJs('js/bootstrap-markdown.js', true)
            ->addJs('js/markdown.js', true);
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
        $contact->assign($this->request->getPost(), array('customerCode', 'name', 'email', 'directDial', 'role'));
        if ($contact->save()) {
            $this->response->redirect('customers/view/' . $contact->customerCode . '/#contacts');
            $this->view->disable;
        } else {
            $this->flashSession->error("Sorry, the contact could not be saved");
            foreach ($contact->getMessages() as $message) {
                $this->flashSession->error($message->getMessage());
            }
            $this->_redirectBack();
        }
    }

    public function updateAction()
    {
        $this->view->disable;
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "contacts",
                "action" => "index"
                ));
        }

        $contact = Contacts::findFirstById($this->request->getPost('id'));
        // Store and check for errors
        $contact->assign($this->request->getPost(), array('directDial', 'email', 'name', 'role', 'customerCode'));
        if ($contact->update()) {
            $this->flash->success("Contact update successfully!");
            return $this->_redirectBack();
        } else {
            $this->flash->error("Sorry, the contact could not be updated");
            foreach ($contact->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }

    public function ajaxupdateAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $response = new \Phalcon\Http\Response();

        $contact = Contacts::findFirstById($this->request->getPost("pk"));
        if (!$contact) {
            $response->setStatusCode(404, "Contact not found");
            $response->send();
        }
        switch ($this->request->getPost('name')) {
            case 'name':
                $contact->name = $this->request->getPost('value');
                break;
            case 'directDial':
                $contact->directDial = $this->request->getPost('value');
                break;
            case 'email':
                $contact->email = $this->request->getPost('value');
                break;
            case 'role':
                $contact->role = $this->request->getPost('value');
                break;
            default:
                $response->setStatusCode(404, "Field not found");
                $response->send();
        }

        if ($contact->update()) {
            $response->setStatusCode(200, "Update successful");
        } else {
            $response->setStatusCode(500, "Something went wrong");
        }
        $response->send();
    }

    public function deleteAction($id)
    {
        $response = new Response();

        $contact = Contacts::findFirstById($id);
        if (!$contact) {
            $this->flash->error("Contact was not found");

            return $response->redirect("contacts/");
        }

        $customerCode = $contact->customerCode;

        if (!$contact->delete()) {
            foreach ($contact->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $response->redirect("contacts/");
        }

        $this->flashSession->success("Contact was deleted successfully");

        return $response->redirect("customers/view/" . $customerCode . "/#contacts");
    }
}
