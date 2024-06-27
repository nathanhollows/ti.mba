<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class OrderTalliesMigration_100
 */
class OrderTalliesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('order_tallies', [
                'columns' => [
                    new Column(
                        'orderNumber',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 7,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'itemNumber',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'orderNumber'
                        ]
                    ),
                    new Column(
                        'pieces',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'itemNumber'
                        ]
                    ),
                    new Column(
                        'length',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 7,
                            'scale' => 3,
                            'after' => 'pieces'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['orderNumber', 'itemNumber'], 'PRIMARY')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '',
                    'ENGINE' => 'InnoDB',
                    'TABLE_COLLATION' => 'utf8mb3_unicode_ci'
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
