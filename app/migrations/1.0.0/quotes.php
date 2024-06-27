<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class QuotesMigration_100
 */
class QuotesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('quotes', [
                'columns' => [
                    new Column(
                        'quoteId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'autoIncrement' => true,
                            'size' => 9,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'webId',
                        [
                            'type' => Column::TYPE_CHAR,
                            'notNull' => true,
                            'size' => 36,
                            'after' => 'quoteId'
                        ]
                    ),
                    new Column(
                        'date',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'webId'
                        ]
                    ),
                    new Column(
                        'customerCode',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 53,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'user',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 37,
                            'after' => 'customerCode'
                        ]
                    ),
                    new Column(
                        'attention',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 30,
                            'after' => 'user'
                        ]
                    ),
                    new Column(
                        'contact',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'attention'
                        ]
                    ),
                    new Column(
                        'notes',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'contact'
                        ]
                    ),
                    new Column(
                        'moreNotes',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 198,
                            'after' => 'notes'
                        ]
                    ),
                    new Column(
                        'reference',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 68,
                            'after' => 'moreNotes'
                        ]
                    ),
                    new Column(
                        'status',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 15,
                            'after' => 'reference'
                        ]
                    ),
                    new Column(
                        'validity',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'default' => "30",
                            'notNull' => false,
                            'size' => 4,
                            'after' => 'status'
                        ]
                    ),
                    new Column(
                        'sale',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'validity'
                        ]
                    ),
                    new Column(
                        'freight',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 6,
                            'scale' => 2,
                            'after' => 'sale'
                        ]
                    ),
                    new Column(
                        'directDial',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 20,
                            'after' => 'freight'
                        ]
                    ),
                    new Column(
                        'leadTime',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 20,
                            'after' => 'directDial'
                        ]
                    ),
                    new Column(
                        'value',
                        [
                            'type' => Column::TYPE_DECIMAL,
                            'notNull' => false,
                            'size' => 10,
                            'scale' => 2,
                            'after' => 'leadTime'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['quoteId'], 'PRIMARY'),
                    new Index('webId', ['webId'], 'UNIQUE'),
                    new Index('webId_3', ['webId'], 'UNIQUE'),
                    new Index('webId_2', ['webId'], '')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '30096',
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
