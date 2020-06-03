<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Escaper;
use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use Phalcon\Flash\Direct as Flash;

class FlashProvider implements ServiceProviderInterface
{
    protected $providerName = 'flash';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, function () {
            $flash = new Flash(null);
            $flash->setImplicitFlush(false);
            $flash->setAutoEscape(false);
            $flash->setCssClasses([
                'error'   => 'alert alert-danger',
                'success' => 'alert alert-success',
                'notice'  => 'alert alert-info',
                'warning' => 'alert alert-warning',
            ]);

            return $flash;
        });
    }
}
