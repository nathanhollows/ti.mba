<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class PacketHistoryMigration_100
 */
class PacketHistoryMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('packet_history', [
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
                        'timestamp',
                        [
                            'type' => Column::TYPE_TIMESTAMP,
                            'default' => "current_timestamp() on update current_timestamp()",
                            'notNull' => true,
                            'after' => 'id'
                        ]
                    ),
                    new Column(
                        'operation',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'timestamp'
                        ]
                    ),
                    new Column(
                        'packetNo',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'operation'
                        ]
                    ),
                    new Column(
                        'orderNo',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 255,
                            'after' => 'packetNo'
                        ]
                    ),
                    new Column(
                        'orderItem',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'orderNo'
                        ]
                    ),
                    new Column(
                        'date',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'orderItem'
                        ]
                    ),
                    new Column(
                        'dateIn',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'date'
                        ]
                    ),
                    new Column(
                        'dateOut',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'dateIn'
                        ]
                    ),
                    new Column(
                        'run',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'dateOut'
                        ]
                    ),
                    new Column(
                        'grade',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'run'
                        ]
                    ),
                    new Column(
                        'treatment',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'grade'
                        ]
                    ),
                    new Column(
                        'dryness',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'treatment'
                        ]
                    ),
                    new Column(
                        'finish',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
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
                        'finishWidth',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'thickness'
                        ]
                    ),
                    new Column(
                        'finishThickness',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'finishWidth'
                        ]
                    ),
                    new Column(
                        'length',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'finishThickness'
                        ]
                    ),
                    new Column(
                        'netCube',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'length'
                        ]
                    ),
                    new Column(
                        'cubeMovement',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'netCube'
                        ]
                    ),
                    new Column(
                        'linealTally',
                        [
                            'type' => Column::TYPE_DOUBLE,
                            'notNull' => false,
                            'after' => 'cubeMovement'
                        ]
                    ),
                    new Column(
                        'cost',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'linealTally'
                        ]
                    ),
                    new Column(
                        'piecesBalance',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'cost'
                        ]
                    ),
                    new Column(
                        'piecesInOut',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'piecesBalance'
                        ]
                    ),
                    new Column(
                        'linealMovement',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'piecesInOut'
                        ]
                    ),
                    new Column(
                        'freightAllowance',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'linealMovement'
                        ]
                    ),
                    new Column(
                        'cocId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'freightAllowance'
                        ]
                    ),
                    new Column(
                        'pack',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => false,
                            'size' => 255,
                            'after' => 'cocId'
                        ]
                    ),
                    new Column(
                        'comment',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'pack'
                        ]
                    ),
                    new Column(
                        'previousPacketHistoryId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'comment'
                        ]
                    ),
                    new Column(
                        'offsite',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'default' => "0",
                            'notNull' => false,
                            'size' => 1,
                            'after' => 'previousPacketHistoryId'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['id'], 'PRIMARY'),
                    new Index('timestamp', ['timestamp'], ''),
                    new Index('packetNo', ['packetNo'], ''),
                    new Index('orderNo', ['orderNo'], '')
                ],
                'options' => [
                    'TABLE_TYPE' => 'BASE TABLE',
                    'AUTO_INCREMENT' => '660104',
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
