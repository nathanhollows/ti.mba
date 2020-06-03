<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Submit;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email as EmailValidate;

class ForgotPasswordForm extends Form
{
    public function initialize()
    {
        $email = new Email('Email', array(
            'placeholder'	=> 'Email',
            'class'			=> 'form-control',
            'required'		=> 'true'
        ));

        $email->addValidators(array(
            new PresenceOf(array(
                'message'	=> 'Email address is required'
            )),
            new EmailValidate(array(
                'message'	=> 'This email is not valid'
            ))
        ));

        $this->add($email);

        $this->add(new Submit('Send', array(
            'class'	=> 'btn btn-primary'
        )));
    }
}
