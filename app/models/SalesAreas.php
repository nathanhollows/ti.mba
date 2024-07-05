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

    public static function findOrdered()
    {
        return SalesAreas::Find([
            'order' => 'ordering ASC',
            'join' => 'App\Models\Users',
        ]);
    }


    // Find all sales areas with reps names
    public function findReps()
    {
        $builder = $this->modelsManager->createBuilder()
            ->columns('name, nicename, agent, rep.name as repName')
            ->from(['customer' => 'App\Models\SalesAreas'])
            ->join('App\Models\Users', 'rep.id = customer.agent', 'rep')
            ->orderBy('rep.name');
        return $builder;
    }

    public function beforeCreate()
    {
        $this->nicename = strtolower(str_replace(" ", "-", $this->name));
    }

    public static function unassigned()
    {
        return parent::find([
            'conditions'    => 'agent IS NULL',
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

    /**
     * Update total sales for the region
     * 
     */
    public static function updateSales()
    {
        $query = new Query(
            "UPDATE orders o
            JOIN (
                SELECT orderNo, SUM(ordered * price) AS value
                FROM order_items i
                JOIN orders o ON i.orderNo = o.orderNumber
                WHERE o.value IS NULL
                OR o.complete IS FALSE
                GROUP BY orderNo
            ) AS subquery ON o.orderNumber = subquery.orderNo
            SET o.value = subquery.value
            WHERE o.value IS NULL
            OR o.complete IS FALSE;
            "
        );

        return $query->execute();
    }

    /**
     * Get a list of customers for the trip planner
     * Used in the plannerAction in 
     * App/Controllers/TripsController.php
     *
     */
    public function tripPlannerQuery()
    {
        $phql = "
            SELECT
                App\Models\SalesAreas.id as id,
                App\Models\SalesAreas.name as area,
                App\Models\Users.name as rep
            FROM App\Models\SalesAreas
            INNER JOIN App\Models\Users
                ON App\Models\SalesAreas.agent = App\Models\Users.id
            ORDER BY App\Models\SalesAreas.ordering ASC
        ";
        return $this->modelsManager->executeQuery($phql);
    }
}
