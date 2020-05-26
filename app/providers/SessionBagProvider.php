<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Session\Bag;

class SessionBagProvider implements ServiceProviderInterface
{

    protected $providerName = 'sessionBag';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () {
            return new Bag('sessionBag');
        });
    }
}
