<?php

namespace App\Models;

use App\Plugins\Auth\Auth;
use App\Models\ContactRecord;
use App\Models\QuoteItems;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Relation;

class Quotes extends Model
{
    public $quoteId;

    public $webId;

    public $date;

    public $customerCode;

    public $user;

    public $attention;

    public $contact;

    public $notes;

    public $moreNotes;

    public $reference;

    public $status;

    public $followUpStatus;

    public $validity;

    public $sale;

    public $freight;

    public $directDial;

    public $leadTime;

    public $value;

    public function initialize()
    {
        $this->hasOne('customerCode', 'App\Models\Customers', 'customerCode', array(
            'alias' => 'customer'
        ));
        $this->hasOne('contact', 'App\Models\Contacts', 'id', array(
            'alias' => 'customerContact'
        ));
        $this->hasOne('user', 'App\Models\Users', 'id', array(
            'alias' => 'rep'
        ));
        $this->hasOne('status', 'App\Models\QuoteStatus', 'id', array(
            'alias' => 'state'
        ));
        $this->hasMany('quoteId', 'App\Models\QuoteItems', 'quoteId', [
            'alias' => 'items',
            'foreignKey' => [
                'action' => Relation::ACTION_CASCADE
            ]
        ]);
        $this->hasMany('quoteId', 'App\Models\ContactRecord', 'reference', [
            'alias' => 'history',
            'foreignKey' => [
                'action' => Relation::ACTION_CASCADE
            ]
        ]);
    }

    public function beforeSave()
    {
        // If a contact is set then remove the legacy 'attention' field
        if (!is_null($this->contact)) {
            $this->attention = null;
        }
    }

    public function beforeCreate()
    {
        if (is_null($this->status)) {
            $this->status = 2;
        }
    }

    public function beforeDelete()
    {
        $this->getitems()->delete();
        $this->gethistory()->delete();
    }

    public static function presented()
    {
        $count = parent::count("MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())");
        $value = parent::sum(array('column' => 'value', 'conditions' => "MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW())"));
        $results = array(
            'value' => $value,
            'count' => $count,
        );
        return $results;
    }

    public static function presentedToday()
    {
        $count = parent::count("date = NOW()");
        $value = parent::sum(array('column' => 'value', 'conditions' => "date = NOW()"));
        $results = array(
            'value' => $value,
            'count' => $count,
        );
        return $results;
    }

    public static function won()
    {
        $results = parent::count("MONTH(date) = MONTH(NOW()) AND YEAR(date) = YEAR(NOW()) AND sale = 1");
        return count($results);
    }

    public function afterCreate()
    {
        $auth = new Auth;
        // Lets make some history
        $history = new ContactRecord();
        $history->date = date('Y-m-d');
        $history->followUpDate = date('Y-m-d');
        $history->customerCode = $this->customerCode;
        $history->user = $auth->getId();
        $history->contactType = 7;
        $history->contact = $this->contact;
        $history->job = $this->quoteId;
        $history->reference = $this->quoteId . " " . $this->reference;
        // history->completed = date('Y-m-d H:i:s');
        $history->details = "Quote " . $this->quoteId . " created by " . $auth->getName();
        $history->save();
    }

    public function getByStatus($status)
    {
        return parent::find(array(
            'conditions' => 'status = ?1',
            'bind' => array(1 => $status),
        ));
    }

    public static function valueByStatus($status)
    {
        return parent::sum(array(
            'column' => 'value',
            'conditions' => 'status = ?1',
            'bind' => array(1 => $status),
        ));
    }

    public static function countByStatus($status)
    {
        return parent::count(array(
            'conditions' => 'status = ?1',
            'bind' => array(1 => $status),
        ));
    }

    public function updateValue()
    {
        $value = 0;
        $value += $this->freight;
        $value += QuoteItems::sum(array(
            'column' => 'lineValue',
            'conditions' => "quoteId = $this->quoteId",
        ));
        $this->value = $value;
        $this->update();
    }

    public static function searchColumns($search)
    {
        $query = self::query();
        $query->where('reference LIKE :search:');
        $query->bind(['search' => '%' . $search . '%']);
        $query->orderBy('quoteId DESC');
        return $query->execute();
    }
}
