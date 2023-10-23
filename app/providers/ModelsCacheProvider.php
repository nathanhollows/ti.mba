<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Cache;
use Phalcon\Di\FactoryDefault;
use Phalcon\Storage\SerializerFactory;
use Phalcon\Cache\Adapter\Stream;

class ModelsCacheProvider implements ServiceProviderInterface
{
    protected $providerName = 'modelsCache';
    
    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () use ($di) {
            $serializerFactory = new SerializerFactory();
            $cacheDir = $di->getShared('config')->path('application.cacheDir') . 'modelsCache/';
            
            $options = [
                'defaultSerializer' => 'Php',
                'lifetime'          => 7200,
                'storageDir'        => $cacheDir,
            ];
            
            $adapter = new Stream($serializerFactory, $options);
            
            return new Cache($adapter);
        });
    }
}
