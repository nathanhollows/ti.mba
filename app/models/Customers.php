<?php

namespace App\Models;

use App\Plugins\Auth\Auth;
use App\Models\ContactRecord;

use Phalcon\Mvc\Model\Relation;

class Customers extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     */
    public $customerCode;

    /**
     *
     * @var string
     */
    public $customerName;

    /**
     *
     * @var string
     */
    public $phone;

    /**
     *
     * @var string
     */
    public $fax;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var string
     */
    public $website;

    /**
     *
     * @var integer
     */
    public $status;

    /**
     *
     * @var integer
     */
    public $rank;

    /**
     *
     * @var string
     */
    public $area;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $date = date("Y-m-d", strtotime('NOW - 3 MONTHS'));
        $year = date("Y-m-d", strtotime('NOW - 1 YEAR'));
        $this->hasOne('status', 'App\Models\CustomerStatus', 'id', array('alias' => 'state'));
        $this->hasOne('salesArea', 'App\Models\SalesAreas', 'id', array('alias' => 'salesArea'));
        $this->hasMany('customerCode', 'App\Models\Addresses', 'customerCode', array('alias'  => 'addresses'));
        $this->hasMany('customerCode', 'App\Models\Contacts', 'customerCode', array('alias' => 'contacts'));
        $this->hasMany('customerCode', 'App\Models\ContactRecord', 'customerCode', array('alias' => 'history'));
        $this->hasMany('customerCode', 'App\Models\Quotes', 'customerCode', array(
                    'alias' => 'quotes',
                    'params' => array(
                        // Open quotes first, then closed
                        'order' => 'if (status < 4, 1, 2), quoteId DESC')));
        // Get all outstanding orders
        $this->hasMany('customerCode', 'App\Models\Orders', 'customerCode', array('alias' => 'orders', 'params' => array('conditions' => 'complete = 0')));
        // Get all orders from the last 3 months
        $this->hasMany('customerCode', 'App\Models\Orders', 'customerCode', array('alias' => 'orders3months', 'params' => array('conditions' => "date >= '$date' OR complete = 0", 'order' => 'orderNumber DESC')));
        // Get all orders from the last year
        $this->hasMany('customerCode', 'App\Models\Orders', 'customerCode', array('alias' => 'orders75', 'params' => array('order' => 'orderNumber DESC', 'limit' => 75)));
    }

    public function beforeSave()
    {
        if ($this->tripDay == 0) {
            $this->tripDay = null;
        }
    }

    public function afterCreate()
    {
        $auth = new Auth;
        // Lets make some history
        $history = new ContactRecord();
        $history->date = date('Y-m-d');
        $history->completed = date('Y-m-d H:i:s');
        $history->customerCode = $this->customerCode;
        $history->user = $auth->getId();
        $history->contactType = 13;
        $history->contact = $this->id;
        $history->details = "Customer created by " . $auth->getName();
        $history->save();
    }

    public static function getActive()
    {
        return parent::find([
            "status NOT IN (2,3)"
        ]);
    }

    public function quotesFrom($date)
    {
        return Quotes::find(array(
            'conditions'     => 'customerCode = ?1 AND date > ?2',
            'bind'          => array(1 => $this->customerCode, 2 => $date),
            'order'         => 'date ASC',
        ));
    }

    public function historyFrom($date)
    {
        return ContactRecord::find(array(
            'conditions'     => 'customerCode = ?1 AND date > ?2',
            'bind'          => array(1 => $this->customerCode, 2 => $date),
            'order'         => 'date DESC',
        ));
    }

    public function beforeDelete()
    {
        if ($this->quotes) {
            return false;
        }
        if ($this->history > 2) {
            return false;
        }
    }

    public static function searchColumns($search)
    {
        $query = self::query();
        $query->where('name LIKE :search:');
        $query->orWhere('customerCode LIKE :search:');
        $query->bind(['search' => '%' . $search . '%']);
        $query->orderBy('name ASC');
        return $query->execute();
    }
}
