<?php

namespace App\Controllers;

use DataTables\DataTable;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\Customers;
use App\Models\Addresses;
use App\Models\CustomerNotes;
use App\Models\ContactRecord;
use App\Models\Quotes;
use App\Forms\CustomersForm;

class CustomersController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->view->pageSubtitle = "Search";
        $this->tag->prependTitle("Search Customers");
        if ($this->request->isAjax()) {
            $builder = $this->modelsManager->createBuilder()
            ->columns('customerCode, customerName, customerFax, customerPhone, customerStatus, customerStatus.style, customerStatus.name')
            ->from('App\Models\Customers')
            ->join('App\Models\CustomerStatus', 'customerStatus = customerStatus.id', 'customerStatus', 'INNER')
            ->orderBy('customerName');

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
            $this->persistent->parameters = null;
        };

        $this->assets->collection('footer')
            ->addJs('js/datatables/companies.js');

        $this->view->headerButton = \Phalcon\Tag::linkTo(array('customers/new', 'New', 'class' => ' btn btn-default pull-right'));
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

        $this->view->parser = new \cebe\markdown\Markdown();
        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flashSession->error("Customer was not found");

            return $this->response->redirect('customers');

            $this->view->disable();
        }

        $quotes = Quotes::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'quoteId DESC'));
        $this->view->quotes = $quotes;

        $history = ContactRecord::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'date DESC',
            'limit'         => 8
            ));
        $this->view->history = $history;

        $notes = CustomerNotes::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'date DESC',
            ));

        $this->view->customerCode = $customer->customerCode;

        $this->view->customer = $customer;
        $this->view->notes = $notes;
        $this->view->headerButton = '
        <!-- Split button -->
        <div class="btn-group pull-right">
            <a class="btn btn-default" data-target="#modal-ajax" href="/followup/?company=' . $customer->customerCode . '" role="button"><i class="fa fa-icon fa-pencil"></i> Add Record</a>
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="/quotes/new/?company=' . $customer->customerCode . '">New Quote</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="/customers/delete/' . $customer->customerCode . '">Delete</a></li>
            </ul>
        </div>
        ';
        \Phalcon\Tag::linkTo(array("followup/?company=" . $customerCode, '<i class="fa fa-plus"></i> Add Record', "class" => "btn btn-default pull-right", "data-target" => "#modal-ajax"));

        $addresses = Addresses::find("customerCode = '$customerCode'");
        $this->view->addresses = $addresses;
        
        $this->view->pageTitle = '<i class="fa fa-building-o" aria-hidden="true"></i> ' . $customer->customerName;
        $this->view->pageSubtitle = $customer->customerCode;
        $this->tag->prependTitle($customer->customerName);

        $this->assets->collection('footer')
            ->addJs('js/datatables/customerQuotes.js');

    }

    public function editAction($customerCode = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $this->view->pageTitle = "Edit";

        $customer = Customers::findFirstByCustomerCode($customerCode);
        $this->view->form = new CustomersForm($customer);

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
     * Updates a customer record
     *
     */

    public function updateAction()
    {

        $this->view->disable;
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
                ));
        }

        $customer = Customers::findFirstBycustomerCode($this->request->getPost('customerCode'));
        // Store and check for errors
        $success = $customer->save($this->request->getPost(), array('customerName', 'customerPhone', 'customerFax', 'customerEmail', 'freightArea', 'freightCarrier', 'customerGroup', 'salesArea', 'customerStatus'));
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
