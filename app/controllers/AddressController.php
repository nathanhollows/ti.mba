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
        // TODO: Implement deleteAction() method
    }

    /**
     * Geocode an address
     *
     * @param int $customerCode
     * @return void
     */
    public function geocodeAction($customerCode)
    {
        $this->view->disable();

        $response = [
            'status' => 'error',
            'message' => 'Invalid request',
            'data' => []
        ];

        $address = Addresses::find([
            'customerCode = :customerCode: AND typeCode = 6 AND lat IS NULL AND lng IS NULL',
            'bind' => [
                'customerCode' => $customerCode
            ]
        ]);

        if (!$address) {
            // No addresses found
            $response['status'] = 'error';
            $response['message'] = 'No such address exists!';
            return $this->response->setStatusCode(404, 'Not Found')->setJsonContent($response);
        }

        $response['status'] = 'success';
        $response['message'] = 'Geocoding addresses';
        $response['data']['customerCode'] = $customerCode;
        $response['data']['geocodedAddresses'] = [];

        foreach ($address as $addr) {
            try {
                $addr->geocode();
                $addr->save();

                $response['data']['geocodedAddresses'][] = [
                    'id' => $addr->id,
                    'lat' => $addr->lat,
                    'lng' => $addr->lng
                ];
            } catch (\Exception $e) {
                // Log the error
                $response['data']['errors'][] = [
                    'id' => $addr->id,
                    'error' => $e->getMessage()
                ];
            }
        }

        return $this->response->setStatusCode(200, 'OK')->setJsonContent($response);
    }
}
