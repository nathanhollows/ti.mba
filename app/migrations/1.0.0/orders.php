<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class OrdersMigration_100
 */
class OrdersMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('orders', [
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
                        'customerCode',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 6,
                            'after' => 'orderNumber'
                        ]
                    ),
                    new Column(
                        'customerRef',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 30,
                            'after' => 'customerCode'
                        ]
                    ),
                    new Column(
                        'date',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => true,
                            'after' => 'customerRef'
                        ]
                    ),
                    new Column(
                        'eta',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'quoted',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'default' => "0",
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'eta'
                        ]
                    ),
                    new Column(
                        'followUp',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'default' => "0",
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'quoted'
                        ]
                    ),
                    new Column(
                        'complete',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'default' => "0",
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'followUp'
                        ]
                    ),
                    new Column(
                        'description',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'complete'
                        ]
                    ),
                    new Column(
                        'cancelled',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'default' => "0",
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'description'
                        ]
                    ),
                    new Column(
                        'scheduled',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'cancelled'
                        ]
                    ),
                    new Column(
                        'location',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'scheduled'
                        ]
                    ),
                    new Column(
                        'value',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'scale' => 2,
                            'after' => 'location'
                        ]
                    ),
                    new Column(
                        'rep',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'value'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['orderNumber'], 'PRIMARY')
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
