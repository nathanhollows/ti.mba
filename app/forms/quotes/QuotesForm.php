<?php

namespace App\Forms\Quotes;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use App\Plugins\Auth\Auth;
use App\Models\Users;
use App\Models\Customers;
use App\Models\Contacts;
use App\Models\QuoteStatus;

class QuotesForm extends Form
{

    /**
     * Initiliaze the quotes form
     */

    public function initialize($entity = null, $option = null)
    {
        $validation = new Validation();

        $id = new Hidden('quoteId');
        $this->add($id);

        $customerCode = new Select(
            'customerCode',
            Customers::find([
                'conditions' => 'status NOT IN (3,4)',
            ]),
            array(
                'using' => array('customerCode', 'name'),
                'required'	=> 'true',
                'useEmpty'	=> true,
                'class' => 'form-control selectpicker',
                'data-live-search' => 'true',
            )
        );
        $customerCode->setLabel("Customer");
        $this->add($customerCode);

        if (isset($entity)) {
            $customerCode = $entity->customerCode;
            $params = array("customerCode = '$customerCode'");
        } else {
            $params = array("customerCode = ''");
        }

        $contact = new Select(
            'contact',
            Contacts::find($params),
            array(
                'using'	=> array('id', 'name'),
                'useEmpty'	=> true,
                'emptyText'	=> 'Select a customer',
                'class'	=> 'form-control',
                'data-live-search' => 'true',
                )
        );
        $contact->setLabel("Contact");
        $this->add($contact);

        $reference = new Text("reference");
        $reference->setAttributes(array(
            'required'	=> 'true',
            'class'		=> 'form-control'
            ));
        $reference->setLabel("Reference");
        $this->add($reference);

        $date = new Date("date");
        $date->setAttributes(array(
            'required'	=> 'true',
            'class'		=> 'form-control'
            ));
        $date->setLabel("Date");
        $date->setDefault(date('d/m/Y'));
        $this->add($date);

        $notes = new TextArea("notes");
        $notes->setAttributes(array(
            'class'		=> 'form-control',
            'placeholder' => 'This will be visible on the quote'
        ));
        $notes->setLabel("Notes");
        $this->add($notes);

        $moreNotes = new TextArea("moreNotes");
        $moreNotes->setAttributes(array(
            'class'		=> 'form-control',
            'placeholder' => 'These will NOT be visible on the quote'
        ));
        $moreNotes->setLabel("Private Notes");
        $this->add($moreNotes);

        $auth = new Auth;
        $salesAgent = new Select(
            "user",
            Users::getActive(),
            array(
                'using'	=> array(
                    'id',
                    'name'
                    ),
                'class'	=> 'form-control'
                )
        );
        $salesAgent->setLabel("Sales Agent");
        $salesAgent->setDefault($auth->getId());
        $this->add($salesAgent);

        $status = new Select(
            "status",
            QuoteStatus::find(),
            array(
                'using'	=> array(
                    'id',
                    'name'
                    ),
                'class'	=> 'form-control'
                )
        );
        $status->setLabel("Status");
        $status->setDefault('2');
        $this->add($status);

        $submit = new Submit("Submit");
        $submit->setAttributes(array(
            'class'	=> 'btn btn-primary shadow',
            ));
        $this->add($submit);
    }
}
