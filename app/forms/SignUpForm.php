<?php

namespace App\Forms;

use Phalcon\Tag;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Password;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\Check;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\Email;
use Phalcon\Validation\Validator\Identical;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Validation\Validator\Confirmation;

class SignUpForm extends Form
{

    public function initialize($entity = null, $options = null)
    {
        $name = new Text('name', array(
            'required'  => 'true',
            'class'     => 'form-control',
        ));

        $name->setLabel('Name');

        $name->addValidators(array(
            new PresenceOf(array(
                'message' => 'The name is required'
            ))
        ));

        $this->add($name);

        // Email
        $email = new Text('email', array(
            'required'  => 'true',
            'class'     => 'form-control',
        ));

        $email->setLabel('E-Mail');

        $email->addValidators(array(
            new PresenceOf(array(
                'message' => 'The e-mail is required'
            )),
            new Email(array(
                'message' => 'The e-mail is not valid'
            ))
        ));

        $this->add($email);

        // Password
        $password = new Password('password', array(
            'required'  => 'true',
            'class'     => 'form-control',
        ));

        $password->setLabel('Password');

        $password->addValidators(array(
            new PresenceOf(array(
                'message' => 'The password is required'
            )),
            new StringLength(array(
                'min' => 6,
                'messageMinimum' => 'Password is too short. Minimum 6 characters'
            )),
            new Confirmation(array(
                'message' => 'Password doesn\'t match confirmation',
                'with' => 'confirmPassword'
            ))
        ));

        $this->add($password);

        // Confirm Password
        $confirmPassword = new Password('confirmPassword', array(
            'required'  => 'true',
            'class'     => 'form-control',
        ));

        $confirmPassword->setLabel('Confirm Password');

        $confirmPassword->addValidators(array(
            new PresenceOf(array(
                'message' => 'The confirmation password is required'
            ))
        ));

        $this->add($confirmPassword);

        // Remember
        $terms = new Check('terms', array(
            'value'     => 'yes',
            'required'  => 'true',
        ));

        $terms->setLabel('Accept terms and conditions');

        $terms->addValidator(new Identical(array(
            'value' => 'yes',
            'message' => 'Terms and conditions must be accepted'
        )));

        $this->add($terms);

        // CSRF
        $csrf = new Hidden('csrf');

        $csrf->addValidator(new Identical(array(
            'value' => $this->security->getSessionToken(),
            'message' => 'CSRF validation failed. ' . Tag::linkTo("signup", "Click here") . ' to try again'
        )));

        $this->add($csrf);

        // Sign Up
        $this->add(new Submit('Sign Up', array(
            'class' => 'btn btn-primary'
        )));
    }

    /**
     * Prints messages for a specific element
     */
    public function messages($name)
    {
        if ($this->hasMessagesFor($name)) {
            foreach ($this->getMessagesFor($name) as $message) {
                $this->flash->error($message);
            }
        }
    }
}