<?php

namespace App\Controllers;

use DataTables\DataTable;
use App\Models\Customers;
use App\Models\Addresses;
use App\Models\Contacts;
use App\Models\CustomerNotes;
use App\Models\ContactRoles;
use App\Models\ContactRecord;
use App\Models\Quotes;
use App\Models\SalesAreas;
use App\Models\Orders;
use App\Models\Users;
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
        $this->tag->prependTitle("Search Customers");
        if ($this->request->isAjax()) {
            $builder = $this->modelsManager->createBuilder()
                ->columns('customerCode, customer.name, fax, phone, customerStatus.style, customerStatus.name as status')
                ->from(['customer' => 'App\Models\Customers'])
                ->join('App\Models\CustomerStatus', 'status = customerStatus.id', 'customerStatus', 'INNER')
                ->where('customerStatus.id NOT IN (3,4)')
                ->orderBy('customer.name');

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
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
     * View a customer
     *
     * @param string $customerCode
     */
    public function viewAction($customerCode)
    {
        $this->view->parser = new \cebe\markdown\Markdown();
        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flashSession->error("Customer was not found");
            return $this->response->redirect('customers/');
        }

        $quotes = Quotes::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'quoteId DESC'));
        $this->view->quotes = $quotes;

        $history = ContactRecord::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'completed IS NULL DESC, date DESC',
            'limit'         => '30',
        ));
        $this->view->history = $history;

        $notes = CustomerNotes::find(array(
            "customerCode = '$customerCode'",
            'order'         => 'date DESC',
        ));

        $this->view->contacts = Contacts::find(array(
            'conditions'    => 'customerCode = ?1',
            'bind'          => array(1 => $customerCode),
            'order'         => 'role ASC, name ASC',
        ));

        $roles = ContactRoles::find(array(
            'order'     => 'name ASC'
        ));
        $rolesstr = "[";
        foreach ($roles as $role) {
            $rolesstr = $rolesstr . '{value: ' . $role->id . ', text: "' . $role->name .'"}, ';
        }
        $rolesstr = $rolesstr . "]";
        $this->view->roles = $rolesstr;

        $this->view->customerCode = $customer->customerCode;

        $this->view->customer = $customer;
        $this->view->notes = $notes;
        if ($customer->rank) {
            $badges[1] = array(
                'text'  => "Rank $customer->rank",
                'icon'  => (($customer->rank <= 10) ? 'trophy faa-tada animated' : 'star'),
            );
        }
        if (isset($customer->salesarea->rep->name)) {
            $badges[2] = array(
                'text'  => $customer->salesarea->rep->name,
                'icon'  => 'user',
                'link'  => '/profile/view/'. $customer->salesarea->rep->id,
            );
        }

        $addresses = Addresses::find("customerCode = '$customerCode'");
        $this->view->addresses = $addresses;

        $this->tag->prependTitle($customer->name);

        $this->view->orders = Orders::find(array(
            'conditions'        => 'customerCode = ?1 AND complete = 0',
            'bind'              => array(1 => $customerCode),
        ));
    }

    public function getcontactsAction($customerCode)
    {
        $this->view->disable();

        if (!$this->request->isAjax()) {
            $this->flashSession->error("You shouldn't be there!");
            return $this->_redirectBack();
        }

        $contacts = Contacts::find(array(
            'columns'    => 'id, name',
            'conditions' => 'customerCode = ?1',
            'bind'       => array(1 => $customerCode),
        ));
        if (!$contacts) {
            $contacts->setStatusCode(404, "No contacts found");
            $contacts->send();
            return true;
        }

        echo '<option value="">Select a Contact</option>';
        foreach ($contacts as $contact) {
            echo '<option value="' . $contact->id . '">' . $contact->name . '</option>';
        }
    }

    public function detailsAction($customerCode = null)
    {
        if ($customerCode == null) {
            $this->_redirectBack();
        }

        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flash->error("The customer could not be found");
            return false;
        } else {
            $this->view->setTemplateBefore('none');
        }

        $quotes = Quotes::findBycustomerCode($customerCode);
        $history = ContactRecord::findBycustomerCode($customerCode);

        $this->view->customer = $customer;
        $this->view->history = $history;
        $this->view->quotes = $quotes;
    }

    public function historyAction($customerCode = null, $year = null, $month = null)
    {
        if ($customerCode == null) {
            $this->_redirectBack();
        }

        $customer = Customers::findFirstBycustomerCode($customerCode);
        if (!$customer) {
            $this->flash->error("The customer could not be found");
            return false;
        } else {
            $this->view->setTemplateBefore('none');
        }

        if (!ctype_digit($year)) {
            $year = date("Y");
        }

        if (!ctype_digit($month)) {
            $month = 01;
        }

        $startDate = date("Y-m-d", strtotime("$year-$month-01"));
        echo $startDate;

        $quotes     = $customer->quotesFrom($startDate);
        $history    = $customer->historyFrom($startDate);

        $this->view->customer = $customer;
        $this->view->history = $history;
        $this->view->quotes = $quotes;
    }

    public function editAction($customerCode = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore('modal-form');
        }

        $this->view->pageTitle = "Edit Customer Details";

        $customer = Customers::findFirstByCustomerCode($customerCode);
        $this->view->form = new CustomersForm($customer);
    }

    /**
     * Creates a new customer
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            return $this->response->redirect("customers/");
        }

        $customer = new Customers();
        $customer->assign(
            $this->request->getPost(),
            array('customerCode', 'name', 'phone', 'fax', 'email', 'salesArea', 'status')
        );
        if (!$customer->save()) {
            foreach ($customer->getMessages() as $message) {
                $this->flashSession->error($message);
            }

            $this->_redirectBack();
        } else {
            // If the customer does save correctly then forward the user to the "View" of the new customer
            $this->flashSession->success("Customer was created successfully");
            $this->response->redirect("customers/view/" . $customer->customerCode);
        }
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

        $customer->assign($this->request->getPost(), array('name', 'phone', 'fax', 'email', 'salesArea', 'customerStatus'));
        if ($customer->update()) {
            $this->flashSession->success("Successfully updated");
        } else {
            $this->flashSession->error("Something went wrong");
            foreach ($customer->getMessages() as $message) {
                $this->flashSession->error($message->getMessage());
            }
        }
        return $this->_redirectBack();
    }

    /**
     * Update a customer using x-editable
     * AJAX only
     */
    public function ajaxupdateAction()
    {
        $this->view->disable();
        if (!$this->request->isPost()) {
            $this->_redirectBack();
        }

        $response = new \Phalcon\Http\Response();

        $customer = Customers::findFirstByCustomerCode($this->request->getPost("pk"));
        if (!$customer) {
            $response->setStatusCode(404, "customer not found");
            $response->send();
        }
        switch ($this->request->getPost('name')) {
            case 'area':
                $customer->salesArea = $this->request->getPost('value');
                break;
            default:
                $response->setStatusCode(404, "Field not found");
                $response->send();
        }

        if ($customer->update()) {
            $response->setStatusCode(200, "Update successful");
        } else {
            $response->setStatusCode(500, "Something went wrong");
        }
        $response->send();
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
            $this->flashSession->error("customer does not exist " . $customerCode);

            return $this->dispatcher->forward(array(
                "controller" => "customers",
                "action" => "index"
            ));
        }

        $customer->customerCode = $this->request->getPost("customerCode");
        $customer->name = $this->request->getPost("name");
        $customer->phone = $this->request->getPost("phone");
        $customer->fax = $this->request->getPost("fax");
        $customer->email = $this->request->getPost("email");
        $customer->salesArea = $this->request->getPost("area");
        $customer->status = $this->request->getPost("status");

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

        $this->flash->success("Customer was updated successfully");

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

    public function detailreportAction($customerCode = null)
    {
        if ($customerCode == null) {
            $this->flashSession->error('The customer code must be entered');
            $this->_redirectBack();
        }

        $company = Customers::findFirstBycustomerCode($customerCode);

        if (!$company) {
            $this->flashSession->error('This is not a valid customer');
            $this->_redirectBack();
        }

        $this->view->company = $company;

        $this->view->setTemplateBefore('none');
        $this->tag->prependTitle('Customer Details Report');
    }

    public function regionsAction($year = null)
    {
        $this->tag->prependTitle("Regions");

        if (is_null($year)) {
            if (date("m") > 4) {
                $date = date("Y-04-01");
            } else {
                $date = date("Y-04-01", strtotime("now - 1 year"));
            }
        } else {
            $date = date("$year-04-01");
        }

        $this->view->year = date("Y", strtotime($date));
        $this->view->date = $date;

        $this->view->users = Users::find();
    }

    public function regionAction($nicename = null)
    {
        $region = SalesAreas::findFirstByNicename($nicename);
        if (!$region) {
            return $this->dispatcher->forward(array(
                "controller" => "error",
                "action" => "show404"
            ));
        }
        $this->tag->prependTitle($region->name);
        $this->view->region = $region;
    }
}
