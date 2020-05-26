<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Url as UrlResolver;

class UrlProvider implements ServiceProviderInterface
{

    protected $providerName = 'url';

    public function register(DiInterface $di): void
    {
        /** @var string $baseUri */
        $baseUri = $di->getShared('config')->path('application.baseUri');

        $di->setShared($this->providerName, function () use ($baseUri) {
            $url = new UrlResolver();
            $url->setBaseUri($baseUri);

            return $url;
        });
    }
}
