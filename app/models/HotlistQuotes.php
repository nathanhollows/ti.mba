<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Models\HotlistFollowing;
use App\Models\HotlistDiscussion;
use App\Plugins\Auth\Auth;

class HotlistQuotes extends Model
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
    public $category;

    /**
     *
     * @var integer
     */
    public $type;

    /**
     *
     * @var string
     */
    public $created;

    /**
     *
     * @var string
     */
    public $value;

    /**
     *
     * @var string
     */
    public $description;

    /**
     *
     * @var string
     */
    public $customer;

    /**
     *
     * @var string
     */
    public $customerCode;


    public function initialize()
    {
        $this->hasOne('category', 'App\Models\HotlistCategories', 'id', array('alias'  => 'group'));
        $this->hasOne('type', 'App\Models\HotlistTypes', 'id', array('alias'  => 'origin'));
        $this->hasMany('id', 'App\Models\HotlistDiscussion', 'id', array('alias'  => 'notes'));
        $this->hasMany('id', 'App\Models\HotlistFollowing', 'id', array('alias'  => 'users'));
        $this->hasOne('user', 'App\Models\Users', 'id', array('alias'  => 'rep'));
    }

    public static function summary()
    {
        return parent::find(array(
            "columns"   => "SUM(value) as sum, COUNT(value) as count",
            "where"     => "completed IS NOT NULL",
        ));
    }
}
