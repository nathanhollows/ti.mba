<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class HotlistCategories extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $name;

    /**
     *
     * @var string
     */
    public $description;

    /**
     *
     * @var bool
     */
    public $system;

    public function initialize()
    {
        $this->hasMany('id', 'App\Models\HotlistQuotes', 'category', array('alias' => 'jobs', 'params' => array('conditions' => 'completed IS NULL')));
    }

}
