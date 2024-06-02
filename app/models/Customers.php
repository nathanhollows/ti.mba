<?php

namespace App\Models;

use App\Plugins\Auth\Auth;
use App\Models\ContactRecord;
use Phalcon\Mvc\Model\Query\Builder;

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
    public $name;

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
    public $salesArea;

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
        $this->hasMany('customerCode', 'App\Models\Contacts', 'customerCode', [
            'alias' => 'contacts',
            'params' => [
                'order' => 'name ASC',
            ]
        ]);
        $this->hasMany('customerCode', 'App\Models\ContactRecord', 'customerCode', array('alias' => 'history'));
        $this->hasMany('customerCode', 'App\Models\Quotes', 'customerCode', array(
            'alias' => 'quotes',
            'params' => array(
                // Open quotes first, then closed
                'order' => 'if (status < 4, 1, 2), quoteId DESC'
            )
        ));
        $this->hasMany('customerCode', 'App\Models\Quotes', 'customerCode', array(
            'alias' => 'activeQuotes',
            'params' => array(
                // Open quotes first, then closed
                'conditions' => 'status IN (1,2,3)',
                'order' => 'quoteId DESC'
            )
        ));
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
        $history->contactType = 3;
        $history->contact = $this->id;
        $history->details = "Customer created by " . $auth->getName();
        $history->save();
    }

    public static function getActive()
    {
        return parent::find([
            'conditions' => 'status IN (1, 2)',
            'order'      => 'name',
        ]);
    }

    public static function getActiveSortedBySalesArea()
    {
        $builder = new Builder();
        return $builder
            ->columns(['customerCode', 'c.name', 's.name as salesArea', 'u.name as salesRep', 'st.name as status', 'st.style as style'])
            ->addFrom('App\Models\Customers', 'c')
            ->leftJoin('App\Models\SalesAreas', 's.id = c.salesArea', 's')
            ->join('App\Models\Users', 'u.id = s.agent', 'u')
            ->join('App\Models\CustomerStatus', 'st.id = c.status', 'st')
            ->where('c.status IN (1, 2)')
            ->orderBy('s.name, c.name')
            ->getQuery()
            ->execute();
    }

    public static function getActiveNoSalesArea()
    {
        $builder = new Builder();
        return $builder
            ->columns(['customerCode', 'c.name', 'st.name as status', 'st.style as style'])
            ->addFrom('App\Models\Customers', 'c')
            ->join('App\Models\CustomerStatus', 'st.id = c.status', 'st')
            ->where('c.status IN (1, 2)')
            ->andWhere('c.salesArea IS NULL')
            ->orderBy('c.name')
            ->getQuery()
            ->execute();
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
