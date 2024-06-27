<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class OrderItemsMigration_100
 */
class OrderItemsMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('order_items', [
                'columns' => [
                    new Column(
                        'orderNo',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'itemNo',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'orderNo'
                        ]
                    ),
                    new Column(
                        'grade',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 8,
                            'after' => 'itemNo'
                        ]
                    ),
                    new Column(
                        'treatment',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 6,
                            'after' => 'grade'
                        ]
                    ),
                    new Column(
                        'dryness',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 6,
                            'after' => 'treatment'
                        ]
                    ),
                    new Column(
                        'finish',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 6,
                            'after' => 'dryness'
                        ]
                    ),
                    new Column(
                        'width',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'finish'
                        ]
                    ),
                    new Column(
                        'thickness',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'width'
                        ]
                    ),
                    new Column(
                        'notes',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'thickness'
                        ]
                    ),
                    new Column(
                        'ordered',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'notes'
                        ]
                    ),
                    new Column(
                        'unit',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'ordered'
                        ]
                    ),
                    new Column(
                        'sent',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'unit'
                        ]
                    ),
                    new Column(
                        'price',
                        [
                            'type' => Column::TYPE_DOUBLE,
                            'notNull' => false,
                            'after' => 'sent'
                        ]
                    ),
                    new Column(
                        'length',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'price'
                        ]
                    ),
                    new Column(
                        'outstanding',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'length'
                        ]
                    ),
                    new Column(
                        'despatch',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'outstanding'
                        ]
                    ),
                    new Column(
                        'complete',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'despatch'
                        ]
                    ),
                    new Column(
                        'comments',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'complete'
                        ]
                    ),
                    new Column(
                        'orderStock',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'comments'
                        ]
                    ),
                    new Column(
                        'despatchNotes',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'orderStock'
                        ]
                    ),
                    new Column(
                        'location',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'despatchNotes'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['orderNo', 'itemNo'], 'PRIMARY')
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
