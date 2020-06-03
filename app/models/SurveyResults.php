<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Query\Builder;

class SurveyResults extends Model
{
    public $id;

    public $timestamp;

    public $contact;

    public $customer;

    public $result1;

    public $result2;

    public $result3;

    public $result4;

    public $result5;

    public $result6;

    public $result7;

    public $result8;

    public $recommend;

    public $feedback;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('customer', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
        $this->belongsTo('contact', 'App\Models\Contacts', 'id', array('alias'  => 'person'));
    }

    public static function countResults($field)
    {
        $builder = new Builder();
        return $builder
            ->columns(array('field' => "$field", 'result' => 'COUNT(*)'))
            ->from('App\Models\SurveyResults')
            ->where("$field IS NOT NULL")
            ->groupBy(array("$field"))
            ->getQuery()
            ->execute();
    }

    public static function countallResults($field)
    {
        return parent::count(array(
            'conditions'    => "$field IS NOT NULL",
        ));
    }
}
