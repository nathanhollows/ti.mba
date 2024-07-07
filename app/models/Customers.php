<?php

namespace App\Models;

use App\Plugins\Auth\Auth;
use App\Models\ContactRecord;
use Phalcon\Mvc\Model\Query\Builder;
use Algolia\AlgoliaSearch\SearchClient;

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
        $this->hasOne('status', \App\Models\CustomerStatus::class, 'id', array('alias' => 'state'));
        $this->hasOne('salesArea', \App\Models\SalesAreas::class, 'id', array('alias' => 'salesArea'));
        $this->hasOne('salesArea', \App\Models\SalesAreas::class, 'id', array('alias' => 'area'));
        $this->hasMany('customerCode', \App\Models\Addresses::class, 'customerCode', array('alias'  => 'addresses'));
        $this->hasMany('customerCode', \App\Models\Contacts::class, 'customerCode', [
            'alias' => 'contacts',
            'params' => [
                'order' => 'name ASC',
            ]
        ]);
        $this->hasMany('customerCode', \App\Models\ContactRecord::class, 'customerCode', array('alias' => 'history'));
        $this->hasMany('customerCode', \App\Models\Quotes::class, 'customerCode', array(
            'alias' => 'quotes',
            'params' => array(
                // Open quotes first, then closed
                'order' => 'if (status < 4, 1, 2), quoteId DESC'
            )
        ));
        $this->hasMany('customerCode', \App\Models\Quotes::class, 'customerCode', array(
            'alias' => 'activeQuotes',
            'params' => array(
                // Open quotes first, then closed
                'conditions' => 'status IN (1,2,3)',
                'order' => 'quoteId DESC'
            )
        ));
        // Get all outstanding orders
        $this->hasMany('customerCode', \App\Models\Orders::class, 'customerCode', array('alias' => 'orders', 'params' => array('conditions' => 'complete = 0')));
        // Get all orders from the last 3 months
        $this->hasMany('customerCode', \App\Models\Orders::class, 'customerCode', array('alias' => 'orders3months', 'params' => array('conditions' => "date >= '$date' OR complete = 0", 'order' => 'orderNumber DESC')));
        // Get the last 75 orders
        $this->hasMany('customerCode', 'App\Models\Orders', 'customerCode', array('alias' => 'orders75', 'params' => array('order' => 'orderNumber DESC', 'limit' => 75)));
        // Trips
        $this->hasMany('customerCode', 'App\Models\TripStops', 'customerCode', array('alias' => 'trips'));
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

    public function getActiveSortedBySalesArea()
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

    public function getActiveNoSalesArea()
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

    /**
     * Get coordinates for a customer
     *
     * @return array
     */
    public function getCoordinates()
    {
        // Get the "Delivery" address
        $address = Addresses::findFirst([
            'customerCode = :customerCode: AND typeCode = 6',
            'bind' => [
                'customerCode' => $this->customerCode
            ]
        ]);
        if ($address) {
            return [
                'lat' => $address->lat,
                'lng' => $address->lng
            ];
        }
        return [
            'lat' => null,
            'lng' => null
        ];
    }

    /**
     * After save
     * Update Algolia index if configured
     *
     */
    public function afterSave()
    {
        // Update Algolia index
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('customers');
            $record = [
                'objectID' => $this->customerCode,
                'customerCode' => $this->customerCode, // This is the primary key, so we need to include it in the record
                'name' => $this->name,
                'phone' => $this->phone,
                'email' => $this->email,
                'status' => $this->state->name,
                'rank' => $this->rank,
                'salesArea' => $this->area->name,
                'salesRep' => $this->area->rep->name,
            ];
            $index->saveObject($record, ['autoGenerateObjectIDIfNotExist' => true]);
        }
    }

    /**
     * After delete
     * Update Algolia index if configured
     * 
     */
    public function afterDelete()
    {
        // Update Algolia index
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('customers');
            $index->deleteObject($this->customerCode);
        }
    }

    /**
     * Push all customers to Algolia
     * 
     */
    public static function pushToAlgolia()
    {
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('customers');

            $builder = new Builder();
            $builder->columns(['customerCode as objectID', 'customerCode', 'c.name', 'c.phone', 'c.email', 'c.rank', 's.name as salesArea', 'u.name as salesRep', 'st.name as status'])
                ->addFrom(\App\Models\Customers::class, 'c')
                ->leftJoin(\App\Models\SalesAreas::class, 's.id = c.salesArea', 's')
                ->join(\App\Models\Users::class, 'u.id = s.agent', 'u')
                ->join(\App\Models\CustomerStatus::class, 'st.id = c.status', 'st')
                ->getQuery();
            $customers = $builder->getQuery()->execute();

            $records = $customers->toArray();
            $index->saveObjects($records, ['autoGenerateObjectIDIfNotExist' => true]);
        }
    }
}
