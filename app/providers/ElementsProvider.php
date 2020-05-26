<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use App\Elements;

class ElementsProvider implements ServiceProviderInterface
{

    protected $providerName = 'elements';

    public function register(DiInterface $di): void
    {
        $di->setShared($this->providerName, Elements::class);
    }
}
