<?php

namespace App;

use Phalcon\Logger;
use Phalcon\Di\Injectable;
use Phalcon\Events\Event;
use Phalcon\Mvc\Dispatcher;
use MyApp\Auth\Adapters\AbstractAdapter;

/**
 * Class NotFoundListener
 *
 * @property AbstractAdapter $auth
 * @property Logger          $logger
 */
class NotFoundListener extends Injectable
{
	public function beforeException(
		Event $event, 
		Dispatcher $dispatcher, 
		\Exception $ex
	) {
		switch ($ex->getCode()) {
		case 2: // Missing controller
		case 5: // Missing action
			$params = [
				'controller' => 'error',
				'action'     => 'show404',
			];

			/**
			 * 404 not logged in
			 */
			if (true !== $this->auth->isLoggedIn()) {
				$params['controller'] = 'session';
				$params['action'] = 'login';
			}

			$dispatcher->forward($params);

			return false;
		default:
			$params = [
				'controller' => 'error',
				'action'     => 'panic',
			];
			echo $ex->getMessage();
			$dispatcher->forward($params);
			// $this->logger->error($ex->getMessage());
			// $this->logger->error($ex->getTraceAsString());
			return false;
		}
	}
}
