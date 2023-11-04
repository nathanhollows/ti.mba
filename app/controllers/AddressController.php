<?php

namespace App\Controllers;

use App\Forms\AddressForm;
use App\Models\Addresses;
use App\Models\CustomerAddresses;

class AddressController extends ControllerBase
{
    public function initialize()
    {
        // Set the default view
        $this->view->setTemplateBefore('private');
        $this->view->setViewsDir('/var/www/html/app/facelift/');
        parent::initialize();
    }

    public function indexAction()
    {
        // No need to have an index for addresses yet
        // Redirect user to dashboard
        $this->response->redirect('dashboard');
    }

    public function newAction($customerCode = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $this->view->pageTitle = "Create an Address";

        $address = new Addresses();
        $address->customerCode = $customerCode;

        $this->view->form = new AddressForm($address);
    }

    public function editAction($id = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $this->view->pageTitle = "Edit an Address";

        $address = Addresses::findFirstByid($id);

        $this->view->form = new AddressForm($address);
    }

    public function createAction()
    {
        $this->view->disable();

        $address = new Addresses();
        // Store and check for errors
        $address->assign($this->request->getPost(), array('customerCode', 'typeCode', 'line1', 'line2', 'line3', 'suburb', 'zipCode', 'city', 'country'));
        if ($address->save()) {
            return $this->_redirectBack();
        } else {
            $this->flash->error("Sorry, the address could not be saved");
            foreach ($address->getMessages() as $message) {
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

        $address = Addresses::findFirstById($this->request->getPost('id'));
        if (!$address) {
            return "No such address exists!";
        }
        // Store and check for errors
        $address->assign($this->request->getPost(), array('typeCode', 'line1', 'line2', 'line3', 'suburb', 'zipCode', 'city', 'country'));
        if ($address->update()) {
            return $this->_redirectBack();
        } else {
            foreach ($address->getMessages() as $message) {
                $this->flash->error($message->getMessage());
            }
        }
    }


    public function deleteAction()
    {
    }
}
