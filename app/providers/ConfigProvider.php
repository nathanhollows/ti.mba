<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Config;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use App\Timba;

class ConfigProvider implements ServiceProviderInterface
{

    protected $providerName = 'config';

    public function register(DiInterface $di): void
    {
        $application = $di->getShared(Timba::APPLICATION_PROVIDER);

        $rootPath = $application->getRootPath();

        $di->setShared($this->providerName, function () use ($rootPath) {
            $config = include $rootPath . '/app/config/config.php';

            return $config;
        });
    }
}
