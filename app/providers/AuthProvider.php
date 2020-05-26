<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use App\Plugins\Auth\Auth;

class AuthProvider implements ServiceProviderInterface
{

    protected $providerName = 'auth';

    public function register(DiInterface $di): void
    {
        $di->setShared($this->providerName, Auth::class);
    }
}
