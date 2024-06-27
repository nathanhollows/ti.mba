<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class QuoteItemsMigration_100
 */
class QuoteItemsMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('quote_items', [
                'columns' => [
                    new Column(
                        'id',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'autoIncrement' => true,
                            'size' => 11,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'quoteId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'width',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'quoteId'
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
                        'grade',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'thickness'
                        ]
                    ),
                    new Column(
                        'finish',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'grade'
                        ]
                    ),
                    new Column(
                        'treatment',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'finish'
                        ]
                    ),
                    new Column(
                        'dryness',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'treatment'
                        ]
                    ),
                    new Column(
                        'lengths',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 250,
                            'after' => 'dryness'
                        ]
                    ),
                    new Column(
                        'qty',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 9,
                            'after' => 'lengths'
                        ]
                    ),
                    new Column(
                        'priceMethod',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'qty'
                        ]
                    ),
                    new Column(
                        'price',
                        [
                            'type' => Column::TYPE_DOUBLE,
                            'notNull' => false,
                            'after' => 'priceMethod'
                        ]
                    ),
                    new Column(
                        'lineValue',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 9,
                            'scale' => 2,
                            'after' => 'price'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['id'], 'PRIMARY')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '324',
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
