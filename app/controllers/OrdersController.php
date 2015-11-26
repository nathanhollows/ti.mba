<?php
 
namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\CustomerOrders;

class OrdersController extends ControllerBase
{
    public function initialize()
    {
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
    }

    /**
     * Searches for customer_orders
     */
    public function searchAction()
    {

        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'App\Models\CustomerOrders', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = array();
        }
        $parameters["order"] = "orderNumber";

        $customer_orders = CustomerOrders::find($parameters);
        if (count($customer_orders) == 0) {
            $this->flash->notice("The search did not find any orders");

            return $this->dispatcher->forward(array(
                "controller" => "orders",
                "action" => "index"
            ));
        }

        $paginator = new Paginator(array(
            "data" => $customer_orders,
            "limit"=> 10,
            "page" => $numberPage
        ));

        $this->view->page = $paginator->getPaginate();
    }

    /**
     * Displays the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a customer_order
     *
     * @param string $orderNumber
     */
    public function editAction($orderNumber)
    {

        if (!$this->request->isPost()) {

            $customer_order = CustomerOrders::findFirstByorderNumber($orderNumber);
            if (!$customer_order) {
                $this->flash->error("customer_order was not found");

                return $this->dispatcher->forward(array(
                    "controller" => "orders",
                    "action" => "index"
                ));
            }

            $this->view->orderNumber = $customer_order->orderNumber;

            $this->tag->setDefault("orderNumber", $customer_order->orderNumber);
            $this->tag->setDefault("customerId", $customer_order->customerId);
            $this->tag->setDefault("customerAddress", $customer_order->customerAddress);
            $this->tag->setDefault("salesAgent", $customer_order->salesAgent);
            $this->tag->setDefault("customerContact", $customer_order->customerContact);
            $this->tag->setDefault("customerOrderNumber", $customer_order->customerOrderNumber);
            $this->tag->setDefault("dateOrdered", $customer_order->dateOrdered);
            $this->tag->setDefault("dateRequired", $customer_order->dateRequired);
            $this->tag->setDefault("complete", $customer_order->complete);
            $this->tag->setDefault("quote", $customer_order->quote);
            $this->tag->setDefault("cancelled", $customer_order->cancelled);
            $this->tag->setDefault("freightCarrier", $customer_order->freightCarrier);
            
        }
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
     * Deletes a customer_order
     *
     * @param string $orderNumber
     */
    public function deleteAction($orderNumber)
    {

        $customer_order = CustomerOrders::findFirstByorderNumber($orderNumber);
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

        $this->flash->success("customer_order was deleted successfully");

        return $this->dispatcher->forward(array(
            "controller" => "orders",
            "action" => "index"
        ));
    }

}
