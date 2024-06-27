<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class BudgetsMigration_100
 */
class BudgetsMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('budgets', [
                'columns' => [
                    new Column(
                        'date',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => true,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'year',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 4,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'month',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 2,
                            'after' => 'year'
                        ]
                    ),
                    new Column(
                        'days',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 2,
                            'after' => 'month'
                        ]
                    ),
                    new Column(
                        'budget',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'days'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['date'], 'PRIMARY'),
                    new Index('date', ['date'], 'UNIQUE')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '',
                    'ENGINE' => 'InnoDB',
                    'TABLE_COLLATION' => 'utf8mb3_general_ci'
                ],
            ]
        );
    }

    /**
     * Run the migrations
     *
     * @return void
     */
    public function up()
    {

    }

    /**
     * Reverse the migrations
     *
     * @return void
     */
    public function down()
    {

    }

}
