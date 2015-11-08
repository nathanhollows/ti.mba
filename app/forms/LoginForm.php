<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email as EmailValidate;
use Phalcon\Validation\Validator\Identical;

class LoginForm extends Form
{

    public function initialize()
    {
        // Email
        $email = new Email('Email', array(
            'placeholder' => 'Email',
            'class'       => 'form-control',
            'required'    => 'true',
        ));

        $email->addValidators(array(
            new PresenceOf(array(
                'message' => 'The e-mail is required'
            )),
            new EmailValidate(array(
                'message' => 'The e-mail is not valid'
            ))
        ));

        $this->add($email);

        // Password
        $password = new Password('password', array(
            'placeholder' => 'Password',
            'class'       => 'form-control',
            'required'    => 'true',
        ));

        $password->setLabel('Password ');

        $password->addValidator(new PresenceOf(array(
            'message' => 'The password is required'
        )));

        $password->clear();

        $this->add($password);

        // Remember
        $remember = new Check('remember', array(
            'value' => 'yes'
        ));

        $remember->setLabel('Remember me');

        $this->add($remember);

        // CSRF
        $csrf = new Hidden('csrf');

        $csrf->addValidator(new Identical(array(
            'value' => $this->security->getSessionToken(),
            'message' => 'CSRF validation failed'
        )));

        $csrf->clear();

        $this->add($csrf);

        $this->add(new Submit('Login', array(
            'class' => 'btn btn-primary'
        )));
    }
}