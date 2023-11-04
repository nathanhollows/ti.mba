<?php

namespace App\Models;

use Phalcon\Mvc\Model\Query;

class SalesAreas extends \Phalcon\Mvc\Model
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
     * @var integer
     */
    public $agent;

    /**
     *
     * @var string
     */
    public $nicename;

    /**
     * 
     * @var string
     */
    public $ordering;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('id', 'App\Models\Customers', 'salesArea', array(
            'alias' => 'customers',
            'params' => [
                "status NOT IN (3,4)"
            ]
        ));
        $this->hasOne('agent', 'App\Models\Users', 'id', array('alias' => 'rep'));
    }

    public function beforeCreate()
    {
        $this->nicename = strtolower(str_replace(" ", "-", $this->name));
    }

    public function afterCreate()
    {
        $this->getDI()->getShared('cache')->delete('sales-areas');
        $this->getDI()->getShared('cache')->delete('unassigned-areas');
    }

    public function afterUpdate()
    {
        $this->getDI()->getShared('cache')->delete('sales-areas');
        $this->getDI()->getShared('cache')->delete('unassigned-areas');
    }

    public function afterDelete()
    {
        $this->getDI()->getShared('cache')->delete('sales-areas');
        $this->getDI()->getShared('cache')->delete('unassigned-areas');
    }

    public function afterSave()
    {
        $this->getDI()->getShared('cache')->delete('sales-areas');
        $this->getDI()->getShared('cache')->delete('unassigned-areas');
    }

    public static function unassigned() 
    {
        return parent::find([
            'conditions'    => 'agent IS NULL',
            'cache'         => array(
                'key'       => 'unassigned-areas',
                'lifetime'  => 86400
            ),
        ]);
    }

    /**
     * Get the sales for the region in the current financial year
     *
     * @param date
     */
    public function getSales($date)
    {
        $query = new Query(
            "SELECT DATE_FORMAT(date, '%Y-%m') period, sum(value) value
				FROM App\Models\Orders o
				JOIN App\Models\Customers c ON c.customerCode = o.customerCode
			WHERE salesArea = :id:
			AND date >= :date:
			GROUP BY period
			ORDER BY period ASC
			LIMIT 12",
            $this->di
        );
        $query->setBindParams([
            "id" => $this->id,
            "date" => $date,
        ]);
        return $query->execute();
    }

    /**
     * Returns a list of top customers by spending
     *
     * @param date
     */
    public function getTopCustomers($date = null)
    {
        if (is_null($date)) {
            $date = date("Y-m-d", strtotime("now - 1 month"));
        } elseif (is_numeric($date)) {
            $date = date("Y-m-d", $date);
        } else {
            $date = date("Y-m-d", strtotime($date));
        }

        $query = new Query(
            "
                select c.name, c.customerCode, round(sum(value),2) value
                from App\Models\Customers c
                join App\Models\Orders o on o.customerCode = c.customerCode
                where salesArea = :id:
                AND date > :date:
                GROUP BY c.customerCode
                ORDER BY value DESC
            ",
            $this->di
        );

        $query->setBindParams([
            "id" => $this->id,
            "date" => $date,
        ]);

        return $query->execute();
    }
}
