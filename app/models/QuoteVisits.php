<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Auth\Auth;

class QuoteVisits extends Model
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
    public $user;

    /**
     *
     * @var int
     */
    public $quoteId;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasOne('quoteId', 'App\Models\Quotes', 'quoteId', array('alias' => 'quote'));
    }

    /**
     * [getLast description]
     * @param  integer  $count [description]
     * @param  integer  $user  [description]
     * @return object          [description]
     */
    public static function getLast($count = 10)
    {
        $auth = new Auth();
        $user = $auth->getId();
        return parent::find(
            array(
                'conditions'    => "user = $user",
                'order'         => 'id DESC',
                'group'         => 'quoteId',
                'limit'         => $count,
            )
        );
    }

}
