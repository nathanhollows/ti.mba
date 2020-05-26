<?php

namespace App\Freight;

use Phalcon\Di\Injectable;
use App\Models\ActivityLog;
use App\Auth\Auth;

class Logger extends Injectable
{
	public function activity($activityType = null)
	{
		$auth = new Auth();

		$activity 				= new ActivityLog();
		$activity->timestamp 	= date('Y-m-d H:is');
		$activity->user 		= $auth->getId;
	}
}
