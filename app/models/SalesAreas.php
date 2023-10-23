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
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('id', 'App\Models\Customers', 'area', array(
            'alias' => 'customers',
            'params' => [
                "customerStatus NOT IN (2,3)"
            ]
        ));
        $this->hasOne('agent', 'App\Models\Users', 'id', array('alias' => 'rep'));
    }

    public function beforeCreate()
    {
        $this->nicename = strtolower(str_replace(" ", "-", $this->name));
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
			WHERE area = :id:
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
select c.customerName, c.customerCode, round(sum(value),2) value
from App\Models\Customers c
join App\Models\Orders o on o.customerCode = c.customerCode
where area = :id:
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
