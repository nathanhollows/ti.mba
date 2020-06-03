<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\TextArea;
use App\Models\Users;
use App\Plugins\Auth\Auth;

class TasksForm extends Form
{
    public function initialize()
    {
        $auth = new Auth;

        $blurb = new TextArea('description', array(
            'required'	=> 'true',
            'class'		=> 'form-control',
            'placeholder'	=> 'Milk, eggs, salami, muesli, chocolate..',
            'autofocus'	=> 'true'));
        $blurb->setLabel("Description");
        $this->add($blurb);

        $user = new Select('user', Users::find(), array(
            'using' 	=> array('id', 'name'),
            'required'	=> 'true',
            'class'		=> 'form-control'));
        $user->setDefault($auth->getId());
        $user->setLabel("User");

        $followUp = new Date('followUp', array(
            'class'		=> 'form-control',
            'value'		=> date('Y-m-d')
        ));
        $followUp->setLabel('Follow Up Date');
        $this->add($followUp);

        $this->add($user);
    }
}
