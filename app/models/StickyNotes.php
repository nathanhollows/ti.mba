<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class StickyNotes extends Model
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
    public $title;

    /**
     *
     * @var string
     */
    public $note;

    /**
     *
     * @var string
     */
    public $expires;

    /**
     *
     * @var string
     */
    public $type;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {

    }

    public static function current()
    {
        return parent::find(array(
            'conditions'    => 'expires >= CURDATE()',
            'order'         => 'id DESC',
        ));
    }

}
