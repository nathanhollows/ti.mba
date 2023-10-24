<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Email;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Hidden ;
use Phalcon\Validation\Validator\PresenceOf;

use App\Models\Contacts;
use App\Models\Customers;
use App\Models\ContactRoles;
use App\Forms\DataListElement;

class ContactsForm extends Form
{
    /**
    * Initialize the contact form
    */
    
    public function initialize($entity = null, $option = null)
    {
        $id = new Hidden("id");
        $this->add($id);
        
        $name = new Text("name");
        $name->setLabel("Name");
        $name->setFilters(array('striptags', 'string'));
        $name->addValidators(array(
            new PresenceOf(array(
                'message'	=> 'Name is required'
                ))
            ));
            $name->setAttributes(array(
                'class'			=> 'form-control',
                'required'		=> 'true'
            ));
            $this->add($name);

            $position = new DataListElement('position', [
                array(
                    'placeholder' => 'Choose an option or type a new one', 
                    'maxlength' => 50,
                    'class' => 'form-control',
                    'name' => 'position',
                    'required' => true
                ),
                ContactRoles::find([
                    'order' => 'name'
                ]),
                array('id', 'name')
            ]);
            $position->setLabel('Position');
            $this->add($position);
            
            $customerCode = new Select(
                'customerCode',
                Customers::find(),
                array(
                    'using' => array('customerCode', 'customerName'),
                    'required'	=> true,
                    'useEmpty'	=> true,
                    'class' => 'form-control selectpicker',
                    'data-live-search' => 'true',
                    )
                );
                $customerCode->setLabel("Customer");
                $customerCode = new Hidden('customerCode');
                $this->add($customerCode);
                
                $email = new Email("email");
                $email->setLabel("Email Address");
                $email->setAttributes(array(
                    'class'			=> 'form-control',
                ));
                $this->add($email);
                
                $phone = new Text("directDial");
                $phone->setLabel("Phone");
                $phone->setAttributes(array(
                    'class'			=> 'form-control',
                ));
                $this->add($phone);
            }
        }
        