<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Cache;
use Phalcon\Cache\AdapterFactory;
use Phalcon\Di\FactoryDefault;
use Phalcon\Storage\SerializerFactory;

class ModelsCacheProvider implements ServiceProviderInterface
{
    protected $providerName = 'modelsCache';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () {
            $serializerFactory = new SerializerFactory();
            $adapterFactory    = new AdapterFactory($serializerFactory);

            $options = [
                'defaultSerializer' => 'Php',
                'lifetime'          => 7200
            ];

            $adapter = $adapterFactory->newInstance('apcu', $options);

            return new Cache($adapter);
        });
    }
}
