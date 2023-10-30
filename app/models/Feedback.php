<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Feedback extends Model
{
    public $time;
    public $user;
    public $uri;
    public $opinion;
    public $feedback;

    public function initialize()
    {
        $this->hasOne("user", "App\Models\Users", "id", [
            "alias" => "rep"
        ]);
    }
}
