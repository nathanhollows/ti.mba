<?php

use Phalcon\Db\Column;
use Phalcon\Db\Index;
use Phalcon\Db\Reference;
use Phalcon\Migrations\Mvc\Model\Migration;

/**
 * Class CalendarMigration_100
 */
class CalendarMigration_100 extends Migration
{
    /**
     * Define the table structure
     *
     * @return void
     */
    public function morph()
    {
        $this->morphTable('calendar', [
                'columns' => [
                    new Column(
                        'calendarDate',
                        [
                            'type' => Column::TYPE_DATE,
                            'notNull' => true,
                            'first' => true
                        ]
                    ),
                    new Column(
                        'day',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 2,
                            'after' => 'calendarDate'
                        ]
                    ),
                    new Column(
                        'month',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 2,
                            'after' => 'day'
                        ]
                    ),
                    new Column(
                        'year',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 4,
                            'after' => 'month'
                        ]
                    ),
                    new Column(
                        'dayOfWeek',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'year'
                        ]
                    ),
                    new Column(
                        'dayOfMonth',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 2,
                            'after' => 'dayOfWeek'
                        ]
                    ),
                    new Column(
                        'dayOfYear',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 3,
                            'after' => 'dayOfMonth'
                        ]
                    ),
                    new Column(
                        'weekOfMonth',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 11,
                            'after' => 'dayOfYear'
                        ]
                    ),
                    new Column(
                        'weekday',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'weekOfMonth'
                        ]
                    ),
                    new Column(
                        'weekend',
                        [
                            'type' => Column::TYPE_TINYINTEGER,
                            'notNull' => true,
                            'size' => 1,
                            'after' => 'weekday'
                        ]
                    ),
                    new Column(
                        'financialYear',
                        [
                            'type' => Column::TYPE_INTEGER,
                            'notNull' => true,
                            'size' => 4,
                            'after' => 'weekend'
                        ]
                    )
                ],
                'indexes' => [
                    new Index('PRIMARY', ['calendarDate'], 'PRIMARY'),
                    new Index('calendar_date', ['calendarDate'], 'UNIQUE'),
                    new Index('weekday', ['weekday'], ''),
                    new Index('weekend', ['weekend'], ''),
                    new Index('day', ['day'], ''),
                    new Index('month', ['month'], ''),
                    new Index('year', ['year'], ''),
                    new Index('dayOfMonth', ['dayOfMonth'], ''),
                    new Index('dayOfYear', ['dayOfYear'], ''),
                    new Index('financialYear', ['financialYear'], '')
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
