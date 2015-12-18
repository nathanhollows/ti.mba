<?php

namespace App\Controllers;
 
use DataTables\DataTable;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\CustomerAddresses;
use App\Models\Customers;
use App\Forms\CustomersForm;

class CustomersController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    {
        if ($this->request->isAjax()) {
          $builder = $this->modelsManager->createBuilder()
                          ->columns('customerCode, customerName, customerFax, customerPhone, customerStatus.style, customerStatus.name')
                          ->from('App\Models\Customers')
                          ->join('App\Models\CustomerStatus', 'customerStatus = customerStatus.id', 'customerStatus', 'INNER')
                          ->orderBy('customerName');

          $dataTables = new DataTable();
          $dataTables->fromBuilder($builder)->sendResponse();
        }
    }

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->view->pageSubtitle = "Search";
        $this->tag->prependTitle("Search Customers");
        $this->persistent->parameters = null;
        };
    }

    /**
     * Displays the creation form
     */
    public function newAction()
    {
        $this->tag->prependTitle("Create Customer");
        $this->persistent->parameters = null;
        $this->view->form = new CustomersForm;
    }

    /**
     * Edits a customer
     *
     * @param string $customerCode
     */
    public function viewAction($customerCode)
    {

        if (!$this->request->isPost()) {

            $customer = Customers::findFirstBycustomerCode($customerCode);
            if (!$customer) {
                $this->flash->error("Customer was not found");

                return $this->dispatcher->forward(array(
                    "controller" => "customers",
                    "action" => "index"
                ));
            }

            $this->view->customerCode = $customer->customerCode;
            $this->tag->setDefault("customerCode", $customer->customerCode);
            $this->tag->setDefault("customerName", $customer->customerName);
            $this->tag->setDefault("customerPhone", $customer->customerPhone);
            $this->tag->setDefault("customerFax", $customer->customerFax);
            $this->tag->setDefault("customerEmail", $customer->customerEmail);
            $this->tag->setDefault("freightArea", $customer->freightArea);
            $this->tag->setDefault("freightCarrier", $customer->freightCarrier);
            $this->tag->setDefault("salesArea", $customer->salesArea);
            $this->tag->setDefault("customerStatus", $customer->customerStatus);
            $this->tag->setDefault("defaultAddress", $customer->defaultAddress);
            $this->tag->setDefault("defaultContact", $customer->defaultContact);
            $this->tag->setDefault("customerGroup", $customer->customerGroup);
            
            $this->view->customer = $customer;
            
            $addresses = CustomerAddresses::find("customerCode = '$customerCode'");
            $this->view->addresses = $addresses;
            $this->view->pageTitle = $customer->customerCode;
            $this->view->pageSubtitle = $customer->customerName;
            $this->tag->prependTitle($customer->customerName);
        }

    }

    /**
     * Creates a new customer
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        $customer = new Customers();

        $customer->customerCode = $this->request->getPost("customerCode");
        $customer->customerName = $this->request->getPost("customerName");
        $customer->customerPhone = $this->request->getPost("customerPhone");
        $customer->customerFax = $this->request->getPost("customerFax");
        $customer->customerEmail = $this->request->getPost("customerEmail");
        $customer->freightArea = $this->request->getPost("freightArea");
        $customer->freightCarrier = $this->request->getPost("freightCarrier");
        $customer->salesArea = $this->request->getPost("salesArea");
        $customer->customerStatus = $this->request->getPost("customerStatus");
        $customer->defaultAddress = $this->request->getPost("defaultAddress");
        $customer->defaultContact = $this->request->getPost("defaultContact");
        $customer->customerGroup = $this->request->getPost("customerGroup");
        

        if (!$customer->save()) {
            foreach ($customer->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "new"
            ));
        }

        $this->flash->success("Customer was created successfully");

        return $this->dispatcher->forward(array(
            "controller" => "customers",
            "action" => "view/" . $customer->customerCode,
        ));
    }

    /**
     * Saves a customer edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        $customerCode = $this->request->getPost("customerCode");

        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flash->error("customer does not exist " . $customerCode);

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        $customer->customerCode = $this->request->getPost("customerCode");
        $customer->customerName = $this->request->getPost("customerName");
        $customer->customerPhone = $this->request->getPost("customerPhone");
        $customer->customerFax = $this->request->getPost("customerFax");
        $customer->customerEmail = $this->request->getPost("customerEmail");
        $customer->freightArea = $this->request->getPost("freightArea");
        $customer->freightCarrier = $this->request->getPost("freightCarrier");
        $customer->salesArea = $this->request->getPost("salesArea");
        $customer->customerStatus = $this->request->getPost("customerStatus");
        $customer->defaultAddress = $this->request->getPost("defaultAddress");
        $customer->defaultContact = $this->request->getPost("defaultContact");
        $customer->customerGroup = $this->request->getPost("customerGroup");
        

        if (!$customer->save()) {

            foreach ($customer->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "edit",
                "params" => array($customer->customerCode)
            ));
        }

        $this->flash->success("customer was updated successfully");

        return $this->dispatcher->forward(array(
            "controller" => "customers",
            "action" => "index"
        ));
    }

    /**
     * Deletes a customer
     *
     * @param string $customerCode
     */
    public function deleteAction($customerCode)
    {
        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flash->error("Customer was not found");

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        if (!$customer->delete()) {

            foreach ($customer->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "search"
            ));
        }

        $this->flash->success("Customer was deleted successfully");

        return $this->dispatcher->forward(array(
            "controller" => "customers",
            "action" => "index"
        ));
    }

}
