<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Mvc\Model\Metadata\Stream as MetaDataAdapter;

class ModelsMetadataProvider implements ServiceProviderInterface
{

    protected $providerName = 'modelsMetadata';

    public function register(DiInterface $di): void
    {
        /** @var string $cacheDir */
        $cacheDir = $di->getShared('config')->path('application.cacheDir');
        $di->set($this->providerName, function () use ($cacheDir) {
            return new MetaDataAdapter([
                'metaDataDir' => $cacheDir . 'metaData/',
            ]);
        });
    }
}
