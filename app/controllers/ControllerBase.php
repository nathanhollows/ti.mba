<?php

use Phalcon\Mvc\Controller,
	Phalcon\Tag;

class ControllerBase extends Controller
{
	protected function initialize()
	{
		Tag::appendTitle(' | ' . SITE_TITLE);
	}
}