<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class ContactRecordMigration_100
 */
class ContactRecordMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('contact_record', [
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
                        'date',
                        [
                            'type' => Column::TYPE_DATETIME,
                            'notNull' => false,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'customerCode',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 6,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'contact',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'customerCode'
                        ]
                    ),
                    new Column(
                        'job',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 10,
                            'after' => 'contact'
                        ]
                    ),
                    new Column(
                        'user',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'job'
                        ]
                    ),
                    new Column(
                        'contactType',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'user'
                        ]
                    ),
                    new Column(
                        'status',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'contactType'
                        ]
                    ),
                    new Column(
                        'reference',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'status'
                        ]
                    ),
                    new Column(
                        'details',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'reference'
                        ]
                    ),
                    new Column(
                        'infoSent',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'details'
                        ]
                    ),
                    new Column(
                        'attachments',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'infoSent'
                        ]
                    ),
                    new Column(
                        'followUpDate',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'attachments'
                        ]
                    ),
                    new Column(
                        'followUpUser',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 5,
                            'after' => 'followUpDate'
                        ]
                    ),
                    new Column(
                        'completed',
                        [
                            'type' => Column::TYPE_TIMESTAMP,
                            'notNull' => false,
                            'after' => 'followUpUser'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['id'], 'PRIMARY'),
                    new Index('id', ['id'], 'UNIQUE'),
                    new Index('customerCode', ['customerCode'], ''),
                    new Index('job', ['job'], ''),
                    new Index('contact', ['contact'], ''),
                    new Index('user', ['user'], '')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '468',
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
