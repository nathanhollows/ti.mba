<?php

namespace App\Controllers;

use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Resultset;
use App\Models\CustomerOrders,
    App\Models\Orders,
    App\Models\ContactRecord,
    App\Models\OrderItems;
use App\Forms\OrdersForm;
include('../vendor/gantti/lib/gantti.php');
use Gantti;
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
        $this->view->headerButton = \Phalcon\Tag::linkTo(array('orders/import', 'Import', 'class' => ' btn btn-default pull-right'));

        $orders = Orders::find(
            array(
                "complete = 0",
                "order" => "orderNumber DESC"
                )
            );
        $this->view->orders = $orders;

        $this->view->scheduled = Orders::scheduled();

        $this->assets->collection("footer")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/Sortable/1.4.2/Sortable.min.js")
            ->addJs("//cdnjs.cloudflare.com/ajax/libs/hideseek/0.7.1/jquery.hideseek.min.js");
            
    }

    public function ganttAction()
    {
        $this->view->noHeader = true;

        $orders = Orders::find(
            array(
                "complete = 0",
                "hydration" => Resultset::HYDRATE_ARRAYS,
            )
        );

        $data = $orders;


        $gantti = new Gantti($data, array(
          'title'      => 'Orders',
          'cellwidth'  => 25,
          'cellheight' => 35,
          'start'   => 'date',
          'end'     => 'eta'
        ));

        $this->view->gantt = $gantti;
    }

    /*
     * Import Action responsible for parsing raw data into database
     */
    public function importAction()
    {
        if ($this->request->isPost()) {
            $string = preg_replace('#\\n(?=[^"]*"[^"]*(?:"[^"]*"[^"]*)*$)#' , ' ', $this->request->getPost('orderDump'));
            $splitOrders = explode(PHP_EOL, $string);
            $i = 0;
            foreach ($splitOrders as $key => $order) {
                $orders[$i] = explode("\t", $order);
                $i++;
            }

            $string = preg_replace('#\\n(?=[^"]*"[^"]*(?:"[^"]*"[^"]*)*$)#' , ' ', $this->request->getPost('itemDump'));
            $splitItems = explode(PHP_EOL, $string);
            $i = 0;
            foreach ($splitItems as $key => $item) {
                $items[$i] = explode("\t", $item);
                $i++;
            }
            unset($orders[0]);

            $allOrders = Orders::find(
                array(
                    'complete = 0',
                    )
                );
            foreach ($allOrders as $key => $order) {
                $order->complete = 1;
                $order->save();
            }

            foreach ($orders as $key => $order) {
                $record = new Orders();
                $record->orderNumber = $order[0];
                $record->customerRef = $order[1];
                $newDateString = date_format(date_create_from_format('d/m/Y', $order[2]), 'Y-m-d');
                $record->date = $newDateString;
                $record->quoted = $order[4];
                $record->complete = 0;
                $record->description = $order[6];
                $record->cancelled = $order[7];
                if ($record->save() == false) {
                    // $this->flash->error("The order import failed");
                    foreach ($record->getMessages() as $message) {
                        $this->flash->error($message . "\n");
                    }
                }
            }

            unset($items[0]);
            foreach ($items as $key => $item) {
                $record = new OrderItems();
                $record->grade = $item[0];
                $record->treatment = $item[1];
                $record->dryness = $item[2];
                $record->finish = $item[3];
                $record->width = $item[4];
                $record->thickness = $item[5];
                $record->length = $item[6];
                $record->dry = $item[7];
                $record->customerCode = $item[8];
                $record->orderNo = $item[9];
                $record->itemNo = $item[10];
                $record->requiredBy = $item[11];
                $record->ordered = $item[12];
                $record->sent = $item[13];
                $record->outstanding = $item[14];
                $record->unit = $item[15];
                $record->despatch = $item[16];
                $record->comments = $item[17];
                $record->orderStock = $item[18];
                $record->notes = $item[19];
                $record->despatchNotes = $item[20];
                $record->location = $item[21];
                if ($record->save() == false) {
                    $this->flash->error("The item import failed");
                    // foreach ($record->getMessages() as $message) {
                    //     $this->flash->error($message . "\n");
                    // }
                }
            }

            $this->view->itemDump = $items;
            $this->view->orderDump = $orders;
        }
    }

    /**
     * Edits a customer_order
     *
     * @param string $orderNumber
     */
    public function viewAction($orderNumber)
    {
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
