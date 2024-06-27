<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class FollowUpMigration_100
 */
class FollowUpMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('follow_up', [
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
                        'customerCode',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 6,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'contact',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 5,
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
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'job'
                        ]
                    ),
                    new Column(
                        'date',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => true,
                            'after' => 'user'
                        ]
                    ),
                    new Column(
                        'notes',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'followUpDate',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'notes'
                        ]
                    ),
                    new Column(
                        'followUpUser',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'followUpDate'
                        ]
                    ),
                    new Column(
                        'followUpNotes',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'followUpUser'
                        ]
                    ),
                    new Column(
                        'completed',
                        [
                            'type' => Column::TYPE_TIMESTAMP,
                            'notNull' => false,
                            'after' => 'followUpNotes'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['id'], 'PRIMARY')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '1',
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
