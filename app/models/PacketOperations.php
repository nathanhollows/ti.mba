<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class PacketOperations extends Model
{
	/**
     *
     * @var int
     */
	public $id;

	/**
     *
     * @var string
     */
	public $shortCode;

	/**
     *
     * @var string
     */
	public $description;

	/**
     *
     * @var string
     */
	public $customerCode;

    public function initialize()
    {
        // Create relationships
    }

}
