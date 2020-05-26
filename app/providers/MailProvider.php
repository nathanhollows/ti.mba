<?php
declare(strict_types=1);

namespace App\Providers;

use Phalcon\Di\DiInterface;
use Phalcon\Di\ServiceProviderInterface;
use App\Mail\Mail;

class MailProvider implements ServiceProviderInterface
{
    protected $providerName = 'mail';

    public function register(DiInterface $di): void
    {
        $di->set($this->providerName, Mail::class);
    }
}
