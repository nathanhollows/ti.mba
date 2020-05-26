<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Events\Event;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Mvc\Dispatcher;

class DispatcherProvider implements ServiceProviderInterface
{

    protected $providerName = 'dispatcher';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () {
            $dispatcher = new Dispatcher();
			$eventsManager = new EventsManager();
			$eventsManager->attach(
				'dispatch:beforeException',
				new \App\NotFoundListener(),
				200
			);
			$dispatcher->setEventsManager($eventsManager);
            $dispatcher->setDefaultNamespace('App\Controllers');

            return $dispatcher;
        });
    }
}
