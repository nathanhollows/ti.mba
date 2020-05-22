<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Resultset;
use Phalcon\Http\Response;
use App\Models\CustomerOrders;
use App\Models\Customers;
use App\Models\Orders;
use App\Models\OrderLocations;
use App\Models\ContactRecord;
use App\Models\OrderItems;
use App\Forms\OrdersForm;

class OrdersController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setViewsDir('/var/www/html/app/facelift/');
        $this->view->setTemplateBefore('private');
        $this->tag->prependTitle('Orders');
        parent::initialize();
    }

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;
        $this->view->headerButton = \Phalcon\Tag::linkTo(array('orders/import', 'Import', 'class' => ' btn btn-default pull-right'));

        $date = date("Y-m-d", strtotime("Now - 1 MONTH"));
        $orders = Orders::find(
            array(
                "complete = 0 OR scheduled = 1",
                "order" => "orderNumber DESC"
            )
        );
        $this->view->orders = $orders;

        $this->assets->collection("footer")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js");

        $this->view->noHeader = true;

        $this->view->locationStats = Orders::count(array(
            "complete = 0",
            "group" => "location",
            "order" => "rowcount DESC"
        ));
        $this->view->countLocations = Orders::countLocations();

        $orderLocations = OrderLocations::find();
        $locationArray = array();
        foreach ($orderLocations as $location) {
            $locationArray[$location->id] = $location->name;
        };
        $this->view->locations = $locationArray;

        $this->view->customers = Customers::getActive();
    }

    /*
     * Import Action responsible for parsing raw data into database
     */
    public function importAction()
    {
        // Runs the import script
        // Connects to the database, fetches all outstanding orders and items and
        // Inserts / Updates the database
        // Requires the despatch planner to have been updated to get new items
        exec('C:\xampp\htdocs\app\script\import_orders.py', $output, $return);
        // Return will return non-zero upon an error
        if (!$return) {
            $this->flashSession->success("Orders updated successfully");
        } else {
            $this->flashSession->error("The orders could not be imported");
        }
        $response = new Response();
        return $response->redirect('orders');
    }

    /**
     * Edits a customer_order
     *
     * @param string $orderNumber
     */
    public function viewAction($orderNumber)
    {
        $this->view->setTemplateBefore('none');
        $order = Orders::findFirstByorderNumber($orderNumber);
        $this->view->order = $order;
        $this->view->pageTitle = "Order " .  $order->orderNumber;
        $this->view->pageSubtitle = $order->customer->customerName;
        $this->view->headerButton = \Phalcon\Tag::linkTo(array("followup/?company=" . $order->customerCode . "&job=" . $order->orderNumber, '<i class="fa fa-pencil"></i> Add Record', "class" => "btn btn-default pull-right", "data-target" => "#modal-ajax"));

        $history = ContactRecord::find(array(
            "job = '$order->orderNumber'",
            'order'         => 'date DESC',
            'limit'         => 8
        ));
        $this->view->parser = new \cebe\markdown\Markdown();
        $this->view->history = $history;

        $this->view->locations = OrderLocations::find(array('conditions' => 'active = 1'));
    }

    /**
     * Creates a new customer_order
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "index"
                ));
        }

        $customer_order = new CustomerOrders();

        $customer_order->customerId = $this->request->getPost("customerId");
        $customer_order->customerAddress = $this->request->getPost("customerAddress");
        $customer_order->salesAgent = $this->request->getPost("salesAgent");
        $customer_order->customerContact = $this->request->getPost("customerContact");
        $customer_order->customerOrderNumber = $this->request->getPost("customerOrderNumber");
        $customer_order->dateOrdered = $this->request->getPost("dateOrdered");
        $customer_order->dateRequired = $this->request->getPost("dateRequired");
        $customer_order->complete = $this->request->getPost("complete");
        $customer_order->quote = $this->request->getPost("quote");
        $customer_order->cancelled = $this->request->getPost("cancelled");
        $customer_order->freightCarrier = $this->request->getPost("freightCarrier");


        if (!$customer_order->save()) {
            foreach ($customer_order->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "new"
                ));
        }

        $this->flash->success("customer_order was created successfully");

        return $this->dispatcher->forward(array(
            "controller" => "orders",
            "action" => "index"
            ));
    }

    /**
     * Saves a customer_order edited
     *
     */
    public function saveAction()
    {
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "index"
                ));
        }

        $orderNumber = $this->request->getPost("orderNumber");

        $customer_order = CustomerOrders::findFirstByorderNumber($orderNumber);
        if (!$customer_order) {
            $this->flash->error("customer_order does not exist " . $orderNumber);

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "index"
                ));
        }

        $customer_order->customerId = $this->request->getPost("customerId");
        $customer_order->customerAddress = $this->request->getPost("customerAddress");
        $customer_order->salesAgent = $this->request->getPost("salesAgent");
        $customer_order->customerContact = $this->request->getPost("customerContact");
        $customer_order->customerOrderNumber = $this->request->getPost("customerOrderNumber");
        $customer_order->dateOrdered = $this->request->getPost("dateOrdered");
        $customer_order->dateRequired = $this->request->getPost("dateRequired");
        $customer_order->complete = $this->request->getPost("complete");
        $customer_order->quote = $this->request->getPost("quote");
        $customer_order->cancelled = $this->request->getPost("cancelled");
        $customer_order->freightCarrier = $this->request->getPost("freightCarrier");


        if (!$customer_order->save()) {
            foreach ($customer_order->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "edit",
                "params" => array($customer_order->orderNumber)
                ));
        }

        $this->flash->success("customer_order was updated successfully");

        return $this->dispatcher->forward(array(
            "controller" => "orders",
            "action" => "index"
            ));
    }

    /**
     * Action for editing orders
     *
     * @param int
     */
    public function editAction($orderNumber = null)
    {
        if ($this->request->isAjax()) {
            $this->view->setTemplateBefore("modal-form");
        }

        if (!isset($orderNumber)) {
            $this->flashSession->error("Missing order number");
            $this->response->redirect("orders");
        }

        $order = Orders::findFirstByorderNumber($orderNumber);
        $this->view->order = $order;
        $this->view->form = new OrdersForm($order);

        $this->view->pageTitle = "Order " . $order->orderNumber . " for " . \Phalcon\Tag::linkTo("customers/view/" . $order->customerCode, $order->customer->customerName);
    }

    /**
     * Updates an order
     *
     */

    public function updateAction()
    {
        $this->view->disable();
        $response = new Response();

        if (!$this->request->isAjax() or !$this->request->isPost()) {
            $this->flashSession->error('Nothing given to update');
            return $this->_redirectBack();
        }

        $order = Orders::findFirstByorderNumber($this->request->getPost("pk"));
        if (!$order) {
            $response->setStatusCode(404, "Order not found");
            $response->setContent('The order could not be found. Woops.');
            $response->send();
            return false;
        }

        switch ($this->request->getPost('name')) {
            case 'eta':
                if ($this->request->getPost('value') == "") {
                    $order->eta = null;
                } else {
                    $order->eta = date("Y-m-d", strtotime($this->request->getPost('value')));
                }
                break;

            case 'notes':
                $order->notes = $this->request->getPost('value');
                break;

            case 'followUp':
                $order->toggleFollowUp();
                break;

            case 'scheduled':
                $order->toggleScheduled();
                break;

            case 'completed':
                $order->toggleCompleted();
                break;

            case 'location':
                $order->location = $this->request->getPost('value');
                break;

            default:
                $response->setStatusCode(400, "Malformed query");
                $response->send();
                break;
        }

        $success = $order->save();

        if ($success) {
            $response->setStatusCode(200);
            $response->setContent('null');
            $response->send();
            return true;
        } else {
            $response->setStatusCode(501, "This could not be updated");
            $response->send();
            return false;
        }
    }

    /**
     * Deletes a customer_order
     *
     * @param string $orderNumber
     */
    public function deleteAction($orderNumber)
    {
        $customer_order = Orders::findFirstByorderNumber($orderNumber);
        if (!$customer_order) {
            $this->flash->error("customer_order was not found");

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "index"
                ));
        }

        if (!$customer_order->delete()) {
            foreach ($customer_order->getMessages() as $message) {
                $this->flash->error($message);
            }

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "search"
                ));
        }

        $this->flash->success("Order was deleted successfully");

        return $this->dispatcher->forward(array(
            "controller" => "orders",
            "action" => "index"
            ));
    }

    public function customerAction($customerCode = null)
    {
        $this->view->setTemplateBefore('none');
        if (!$this->request->isAjax()) {
            $response = new Response();
            return $response->redirect('orders');
        }
        if (is_null($customerCode)) {
            $this->flash->error('Invalid URL');
            return true;
        }

        $customer = Customers::findFirstByCustomerCode($customerCode);
        if (!$customer) {
            $this->flash->error('Customer not found');
            return true;
        }
        $this->view->customer = $customer;
    }

    public function outstandingAction()
    {
        $this->view->setTemplateBefore('none');
        if (!$this->request->isAjax()) {
            $response = new Response();
            return $response->redirect('orders');
        }

        $this->view->orders = Orders::find(
            array(
                "complete = 0",
                "order" => "orderNumber DESC"
            )
        );
    }
}
