<?php
declare(strict_types=1);

namespace App\Providers;

use Exception;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Mvc\Router;
use App\Timba;

class RouterProvider implements ServiceProviderInterface
{

    protected $providerName = 'router';

    public function register(DiInterface $di): void
    {
        $application = $di->getShared(Timba::APPLICATION_PROVIDER);

        $basePath = $application->getRootPath();

        $di->set($this->providerName, function () use ($basePath) {
            $router = new Router();

            $routes = $basePath . '/app/config/routes.php';
            if (!file_exists($routes) || !is_readable($routes)) {
                throw new Exception($routes . ' file does not exist or is not readable.');
            }

            require_once $routes;

            return $router;
        });
    }
}
