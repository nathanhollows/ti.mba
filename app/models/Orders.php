<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query\Builder;
use App\Models\OrdersCompleted;

class Orders extends Model
{
    /**
     * Internal reference to order number
     * @var int
     */
    public $orderNumber;

    /**
     * Customer reference to order
     * @var string
     */
    public $customerRef;

    /**
     * Date the order was placed
     * @var string
     */
    public $date;

    /**
     * If the order was quoted beforehand
     * @var boolean
     */
    public $quoted;

    /**
     * Has the order been completed
     * @var boolean
     */
    public $complete;

    /**
     * Order notes from the customer
     * @var string
     */
    public $description;

    /**
     * Despatcher notes
     * @var string
     */
    public $notes;

    /**
     * Has the order been cancelled
     * @var boolean
     */
    public $cancelled;

    /**
     * Date the latest ETA was loaded against an order
     * @var string
     */
    public $checked;

    /**
     * When to alert the despatcher to follow up this order
     * @var string
     */
    public $followUpDate;

    /**
     * Reason to alert dispatcher
     * @var string
     */
    public $followUpReason;

    /**
     * Sales rep
     * @var string
     */
    public $rep;

    /**
     * Define relationships
     */
    public function initialize()
    {
        $this->keepSnapshots(true);
        $this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array('alias' => 'customer'));
        $this->hasMany('orderNumber', 'App\Models\OrderItems', 'orderNo', array('alias' => 'items'));
        $this->hasOne('location', 'App\Models\OrderLocations', 'id', array('alias'  => 'whereabouts'));
        $this->hasMany('orderNumber', 'App\Models\Dockets', 'orderNo', array('alias' => 'dockets'));
    }

    /**
     * If eta has changed then update checked date
     */
    public function beforeUpdate()
    {
        if ($this->hasChanged('eta')) {
            $this->checked = date("Y-m-d H:i:s");
            $this->followUp = 0;
        }
    }

    /**
     * Fetch all current orders
     * @return Orders
     */
    public static function getCurrent()
    {
        return self::find([
            'conditions'    => 'complete = 0'
        ]);
    }

    /**
     * Fetch all scheduled orders
     * @return Orders
     */
    public static function getScheduled()
    {
        return self::find([
            'conditions'    => 'complete = 0 AND scheduled = 1'
        ]);
    }

    public function toggleFollowUp()
    {
        if ($this->followUp == 1) {
            $this->followUp = 0;
            $this->followUpReason = null;
        } else {
            $this->followUp = 1;
            $this->followUpReason = "Toggled to follow up";
        }
        return true;
    }

    public function toggleScheduled()
    {
        if ($this->scheduled == 1) {
            $this->scheduled = 0;
        } else {
            $this->scheduled = 1;
        }
        return true;
    }

    public function toggleCompleted()
    {
        if ($this->complete < 1) {
            $completed = new OrdersCompleted();
            $completed->orderNumber = $this->orderNumber;
            $completed->save();
            $this->complete = 1;
        } else {
            $completed = OrdersCompleted::findFirst($this->orderNumber);
            if ($completed) {
                $completed->delete();
            }
            $this->complete = 0;
        }
        return true;
    }

    public static function countLocations()
    {
        $builder = new Builder();
        return $builder
            ->columns(array('location' => 'l.name', 'complete' => 'o.complete', 'total' => 'COUNT(o.orderNumber)'))
            ->addFrom('App\Models\Orders', 'o')
            ->join('App\Models\OrderLocations', 'l.id = o.location', 'l')
            ->where("o.complete = 0")
            ->groupBy("location")
            ->getQuery()
            ->execute();
    }

    public static function searchColumns($search)
    {
        $query = self::query();
        $query->where('customerCode LIKE :search:');
        $query->orWhere('customerRef LIKE :search:');
        $query->bind(['search' => '%' . $search . '%']);
        $query->orderBy('orderNumber ASC');
        return $query->execute();
    }
}
