<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class CustomerAddressesMigration_100
 */
class CustomerAddressesMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('customer_addresses', [
                'columns' => [
                    new Column(
                        'customerAddressId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'autoIncrement' => true,
                            'size' => 11,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'addressId',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'customerAddressId'
                        ]
                    ),
                    new Column(
                        'typeCode',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'addressId'
                        ]
                    ),
                    new Column(
                        'customerCode',
                        [
                            'type' => Column::TYPE_VARCHAR,
                            'notNull' => true,
                            'size' => 6,
                            'after' => 'typeCode'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['customerAddressId'], 'PRIMARY'),
                    new Index('addressId', ['customerAddressId'], 'UNIQUE'),
                    new Index('addressId_2', ['addressId', 'typeCode', 'customerCode'], ''),
                    new Index('typeCode', ['typeCode'], ''),
                    new Index('customerCode', ['customerCode'], '')
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
