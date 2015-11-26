<?php

namespace App\Models;

class CustomerOrderItems extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var integer
     */
    public $orderNumber;

    /**
     *
     * @var integer
     */
    public $lineNumber;

    /**
     *
     * @var integer
     */
    public $width;

    /**
     *
     * @var integer
     */
    public $thickness;

    /**
     *
     * @var integer
     */
    public $finishWidth;

    /**
     *
     * @var integer
     */
    public $finishThickness;

    /**
     *
     * @var integer
     */
    public $length;

    /**
     *
     * @var integer
     */
    public $grade;

    /**
     *
     * @var integer
     */
    public $treatment;

    /**
     *
     * @var integer
     */
    public $dryness;

    /**
     *
     * @var integer
     */
    public $finish;

    /**
     *
     * @var integer
     */
    public $notes;

    /**
     *
     * @var integer
     */
    public $cost;

    /**
     *
     * @var integer
     */
    public $costMethod;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'customer_order_items';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerOrderItems[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerOrderItems
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return array(
            'id' => 'id',
            'orderNumber' => 'orderNumber',
            'lineNumber' => 'lineNumber',
            'width' => 'width',
            'thickness' => 'thickness',
            'finishWidth' => 'finishWidth',
            'finishThickness' => 'finishThickness',
            'length' => 'length',
            'grade' => 'grade',
            'treatment' => 'treatment',
            'dryness' => 'dryness',
            'finish' => 'finish',
            'notes' => 'notes',
            'cost' => 'cost',
            'costMethod' => 'costMethod'
        );
    }

}
