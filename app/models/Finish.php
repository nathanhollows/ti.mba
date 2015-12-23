<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Finish extends Model
{
	/**
     *
     * @var integer
     */
	public function $id;

	/**
     *
     * @var string
     */
	public function $shortCode;

	/**
     *
     * @var string
     */
	public function $name;
}