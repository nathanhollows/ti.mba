<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class SpeciesMigration_100
 */
class SpeciesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('species', [
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
                        'name',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => true,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'scientificName',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => true,
                            'after' => 'name'
                        ]
                    ),
                    new Column(
                        'hardwood',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'scientificName'
                        ]
                    ),
                    new Column(
                        'native',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'hardwood'
                        ]
                    ),
                    new Column(
                        'imported',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'native'
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
