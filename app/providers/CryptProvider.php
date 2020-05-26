<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Crypt;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;

class CryptProvider implements ServiceProviderInterface
{

    protected $providerName = 'crypt';

    public function register(DiInterface $di): void
    {

        $cryptSalt = $di->getShared('config')->path('application.cryptSalt');

        $di->set($this->providerName, function () use ($cryptSalt) {
            $crypt = new Crypt();
            $crypt->setKey($cryptSalt);

            return $crypt;
        });
    }
}
