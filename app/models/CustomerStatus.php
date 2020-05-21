<?php

namespace App\Models;

class CustomerStatus extends \Phalcon\Mvc\Model
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
     * @var integer
     */
    public $active;

    /**
     *
     * @var integer
     */
    public $warning;

    /**
     *
     * @var string
     */
    public $statusNote;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('id', 'App\Models\Customers', 'customerStatus');
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CustomerStatus
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
