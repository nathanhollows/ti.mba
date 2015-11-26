<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class CustomerOrders extends Model
{

    /**
     *
     * @var integer
     */
    protected $orderNumber;

    /**
     *
     * @var string
     */
    protected $customerId;

    /**
     *
     * @var integer
     */
    protected $customerAddress;

    /**
     *
     * @var integer
     */
    protected $salesAgent;

    /**
     *
     * @var integer
     */
    protected $customerContact;

    /**
     *
     * @var string
     */
    protected $customerOrderNumber;

    /**
     *
     * @var string
     */
    protected $dateOrdered;

    /**
     *
     * @var string
     */
    protected $dateRequired;

    /**
     *
     * @var integer
     */
    protected $complete;

    /**
     *
     * @var integer
     */
    protected $quote;

    /**
     *
     * @var integer
     */
    protected $cancelled;

    /**
     *
     * @var integer
     */
    protected $freightCarrier;

    /**
     * Method to set the value of field orderNumber
     *
     * @param integer $orderNumber
     * @return $this
     */
    public function setOrderNumber($orderNumber)
    {
        $this->orderNumber = $orderNumber;

        return $this;
    }

    /**
     * Method to set the value of field customerId
     *
     * @param string $customerId
     * @return $this
     */
    public function setCustomerId($customerId)
    {
        $this->customerId = $customerId;

        return $this;
    }

    /**
     * Method to set the value of field customerAddress
     *
     * @param integer $customerAddress
     * @return $this
     */
    public function setCustomerAddress($customerAddress)
    {
        $this->customerAddress = $customerAddress;

        return $this;
    }

    /**
     * Method to set the value of field salesAgent
     *
     * @param integer $salesAgent
     * @return $this
     */
    public function setSalesAgent($salesAgent)
    {
        $this->salesAgent = $salesAgent;

        return $this;
    }

    /**
     * Method to set the value of field customerContact
     *
     * @param integer $customerContact
     * @return $this
     */
    public function setCustomerContact($customerContact)
    {
        $this->customerContact = $customerContact;

        return $this;
    }

    /**
     * Method to set the value of field customerOrderNumber
     *
     * @param string $customerOrderNumber
     * @return $this
     */
    public function setCustomerOrderNumber($customerOrderNumber)
    {
        $this->customerOrderNumber = $customerOrderNumber;

        return $this;
    }

    /**
     * Method to set the value of field dateOrdered
     *
     * @param string $dateOrdered
     * @return $this
     */
    public function setDateOrdered($dateOrdered)
    {
        $this->dateOrdered = $dateOrdered;

        return $this;
    }

    /**
     * Method to set the value of field dateRequired
     *
     * @param string $dateRequired
     * @return $this
     */
    public function setDateRequired($dateRequired)
    {
        $this->dateRequired = $dateRequired;

        return $this;
    }

    /**
     * Method to set the value of field complete
     *
     * @param integer $complete
     * @return $this
     */
    public function setComplete($complete)
    {
        $this->complete = $complete;

        return $this;
    }

    /**
     * Method to set the value of field quote
     *
     * @param integer $quote
     * @return $this
     */
    public function setQuote($quote)
    {
        $this->quote = $quote;

        return $this;
    }

    /**
     * Method to set the value of field cancelled
     *
     * @param integer $cancelled
     * @return $this
     */
    public function setCancelled($cancelled)
    {
        $this->cancelled = $cancelled;

        return $this;
    }

    /**
     * Method to set the value of field freightCarrier
     *
     * @param integer $freightCarrier
     * @return $this
     */
    public function setFreightCarrier($freightCarrier)
    {
        $this->freightCarrier = $freightCarrier;

        return $this;
    }

    /**
     * Returns the value of field orderNumber
     *
     * @return integer
     */
    public function getOrderNumber()
    {
        return $this->orderNumber;
    }

    /**
     * Returns the value of field customerId
     *
     * @return string
     */
    public function getCustomerId()
    {
        return $this->customerId;
    }

    /**
     * Returns the value of field customerAddress
     *
     * @return integer
     */
    public function getCustomerAddress()
    {
        return $this->customerAddress;
    }

    /**
     * Returns the value of field salesAgent
     *
     * @return integer
     */
    public function getSalesAgent()
    {
        return $this->salesAgent;
    }

    /**
     * Returns the value of field customerContact
     *
     * @return integer
     */
    public function getCustomerContact()
    {
        return $this->customerContact;
    }

    /**
     * Returns the value of field customerOrderNumber
     *
     * @return string
     */
    public function getCustomerOrderNumber()
    {
        return $this->customerOrderNumber;
    }

    /**
     * Returns the value of field dateOrdered
     *
     * @return string
     */
    public function getDateOrdered()
    {
        return $this->dateOrdered;
    }

    /**
     * Returns the value of field dateRequired
     *
     * @return string
     */
    public function getDateRequired()
    {
        return $this->dateRequired;
    }

    /**
     * Returns the value of field complete
     *
     * @return integer
     */
    public function getComplete()
    {
        return $this->complete;
    }

    /**
     * Returns the value of field quote
     *
     * @return integer
     */
    public function getQuote()
    {
        return $this->quote;
    }

    /**
     * Returns the value of field cancelled
     *
     * @return integer
     */
    public function getCancelled()
    {
        return $this->cancelled;
    }

    /**
     * Returns the value of field freightCarrier
     *
     * @return integer
     */
    public function getFreightCarrier()
    {
        return $this->freightCarrier;
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'customer_orders';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerOrders[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerOrders
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
