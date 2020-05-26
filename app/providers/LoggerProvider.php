<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Config;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Logger\Adapter\Stream as FileLogger;
use Phalcon\Logger\Formatter\Line as FormatterLine;

class LoggerProvider implements ServiceProviderInterface
{
    protected $providerName = 'logger';

    public function register(DiInterface $di): void
    {
        /** @var Config $loggerConfigs */
        $loggerConfigs = $di->getShared('config')->get('logger');

        $di->set($this->providerName, function () use ($loggerConfigs) {
            $filename = trim($loggerConfigs->get('filename'), '\\/');
            $path     = rtrim($loggerConfigs->get('path'), '\\/') . DIRECTORY_SEPARATOR;

            $formatter = new FormatterLine($loggerConfigs->get('format'), $loggerConfigs->get('date'));
            $logger    = new FileLogger($path . $filename);

            $logger->setFormatter($formatter);

            return $logger;
        });
    }
}
