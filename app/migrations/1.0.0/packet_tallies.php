<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class PacketTalliesMigration_100
 */
class PacketTalliesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('packet_tallies', [
                'columns' => [
                    new Column(
                        'packetNo',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'length',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => true,
                            'after' => 'packetNo'
                        ]
                    ),
                    new Column(
                        'count',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'length'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['packetNo', 'length'], 'PRIMARY')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '',
                    'ENGINE' => 'InnoDB',
                    'TABLE_COLLATION' => 'utf8mb4_general_ci'
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
