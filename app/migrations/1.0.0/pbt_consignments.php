<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class PbtConsignmentsMigration_100
 */
class PbtConsignmentsMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('pbt_consignments', [
                'columns' => [
                    new Column(
                        'conNote',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 11,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'pbtConsignmentNote',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'default' => "",
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'conNote'
                        ]
                    ),
                    new Column(
                        'numberOfItems',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'pbtConsignmentNote'
                        ]
                    ),
                    new Column(
                        'weight',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'numberOfItems'
                        ]
                    ),
                    new Column(
                        'pickupDate',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'weight'
                        ]
                    ),
                    new Column(
                        'podDate',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => false,
                            'after' => 'pickupDate'
                        ]
                    ),
                    new Column(
                        'podTime',
                        [
                            'type' => Column::TYPE_TIME,
                            'notNull' => false,
                            'after' => 'podDate'
                        ]
                    ),
                    new Column(
                        'deliveryBy',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'podTime'
                        ]
                    ),
                    new Column(
                        'podSignature',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'deliveryBy'
                        ]
                    ),
                    new Column(
                        'deliveryCourier',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'podSignature'
                        ]
                    ),
                    new Column(
                        'ticketNo',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'deliveryCourier'
                        ]
                    ),
                    new Column(
                        'cost',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'ticketNo'
                        ]
                    ),
                    new Column(
                        'runsheet',
                        [
                            'type' => Column::TYPE_TEXT,
                            'notNull' => false,
                            'after' => 'cost'
                        ]
                    ),
                    new Column(
                        'accountNo',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => false,
                            'size' => 11,
                            'after' => 'runsheet'
                        ]
                    ),
                    new Column(
                        'volume',
                        [
                            'type' => Column::TYPE_FLOAT,
                            'notNull' => false,
                            'after' => 'accountNo'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['pbtConsignmentNote'], 'PRIMARY'),
                    new Index('idx_name', ['pbtConsignmentNote'], 'UNIQUE')
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
