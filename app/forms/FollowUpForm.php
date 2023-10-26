<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Submit;

use App\Plugins\Auth\Auth;

use App\Models\Customers;
use App\Models\Contacts;
use App\Models\Users;

class FollowUpForm extends Form
{
    // Initialize the Follow Up form
    public function initialize($entity = null, $option = null)
    {
        $id = new Hidden("id");
        $this->add($id);

        $conditions = [
            "order"	=> "name",
        ];
        if (isset($option["customerCode"])) {
            $customer = new Hidden("customerCode");
            $customer->setDefault($option["customerCode"]);
            $conditions = array(
                "conditions"	=> "customerCode = ?1",
                "bind"			=> array(1 => $option['customerCode']),
                "order"	=> "name",
            );
        } else {
            $customer = new Select(
                "customerCode",
                Customers::find([
                    "order"	=> "name",
                    "conditions" => "customerStatus IN (1,4)",
                ]),
                array(
                    'using'	=> array(
                        'customerCode',
                        'name',
                    ),
                    'class'	=> "form-control selectpicker",
                    'data-live-search' => 'true',
                    'useEmpty'	=> true,
                )
            );
            $customer->setLabel("Customer");
        }
        $this->add($customer);

        $contact = new Select(
            "contact",
            Contacts::find($conditions),
            array(
                'using'	=> array(
                    'id',
                    'name'
                ),
            'class'	=> 'form-control selectpicker',
            'data-live-search' => 'true',
            'useEmpty'	=> true,
            'emptyText' => 'Select a Contact...',
            )
        );
        $contact->setLabel("Contact");
        $this->add($contact);

        $job = new Hidden("job");
        $job->setAttributes(array(
            'class'		=> 'form-control',
            'placeholder'	=> 'Quote Number',
            ));
        $job->setLabel("Job");
        $this->add($job);

        $reference = new Text("reference");
        $reference->setAttributes(array(
            'class'		=> 'form-control',
            ));
        $reference->setLabel("Title");
        $this->add($reference);

        $details = new TextArea("details");
        $details->setAttributes(array(
            'required'	=>"true",
            'class'		=> 'form-control',
            'autofocus'	=> 'true',
            'rows' => '4',
            ));
        $details->setLabel("Details");
        $this->add($details);

        $theDate = date('Y-m-d', strtotime("+1 weeks"));
        if (isset($option["followUpDate"])) {
            $theDate = $option["followUpDate"];
        }

        $date = new Date("followUpDate");
        $date->setAttributes(array(
            'value'		=> $theDate,
            'required'	=> 'true',
            'class'		=> 'form-control'
            ));
        $date->setLabel("Date");
        $this->add($date);

        $recordDate = new Date('recordDate');
        $recordDate->setAttributes(array(
            'value'		=> date("Y-m-d"),
            'required'      => 'true',
            'class'		=> 'form-control'
        ));
        $recordDate->setDefault($entity->date);
        $this->add($recordDate);

        $auth = new Auth();

        $rep = new Hidden("user");
        $rep->setDefault($auth->getId());
        $this->add($rep);

        $submit = new Submit("submit");
        $submit->setAttributes(array(
            'class'	=> 'btn btn-primary'
        ));
        $this->add($submit);
    }
}
