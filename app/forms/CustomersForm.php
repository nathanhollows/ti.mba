<?php

namespace App\forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\numeric;

use App\Models\CustomerGroups;
use App\Models\CustomerStatus;
use App\Models\SalesAreas;
use App\Models\FreightAreas;
use App\Models\FreightCarriers;

class CustomersForm extends Form
{
    // Initialize the customers form
    public function initialize($entity = null, $option = null)
    {
        if (!isset($options['edit'])) {
            $element = new Text("customerCode");
            $this->add($element->setLabel("Code"));
            $element->setFilters(array('striptags', 'string'));
            $element->setAttributes(
                array(
                'class'			=> 'form-control',
                'required'		=> 'true'
                )
            );
        } else {
            $this->add(new Hidden("customerCode"));
        }


        // Customer name
        // Text field
        $name = new Text("name");
        $name->setLabel("Name");
        $name->setFilters(array('striptags', 'string'));
        $name->setAttributes(
            array(
            'class'			=> 'form-control',
            'required'		=> 'true'
            )
        );
        $this->add($name);

        // Customer phone
        // Text field
        $phone = new Text("phone");
        $phone->setLabel("Phone Number");
        $phone->setFilters(array('striptags', 'string'));
        $phone->setAttributes(
            array(
            'class'			=> 'form-control',
            )
        );
        $this->add($phone);

        // Customer fax
        // Text field
        $fax = new Text("fax");
        $fax->setLabel("Fax Number");
        $fax->setFilters(array('striptags', 'string'));
        $fax->setAttributes(
            array(
            'class'			=> 'form-control',
            )
        );
        $this->add($fax);

        // Customer email
        // Text field
        $email = new Text("email");
        $email->setLabel("Email");
        $email->setFilters(array('striptags', 'string'));
        $email->setAttributes(
            array(
            'class'			=> 'form-control',
            )
        );
        $this->add($email);

        // Customer group
        // Select field
        // $group = new Select(
        // 'customerGroup',
        // CustomerGroups::find(),
        // array(
        // 'using'		=> array('id', 'name'),
        // 'useEmpty'	=> true,
        // 'emptyTest'	=> '...',
        // 'emptyValue'=> '',
        // 'class'		=> 'form-control',
        // )
        // );
        // $group->setLabel('Customer Group');
        // $this->add($group);

        // Trip Day
        // Numeric Field
        // $tripDay = new Numeric('tripDay',
        // array(
        // 'class'		=> 'form-control',
        // )
        // );
        // $tripDay->setLabel('Trip Day');
        // $this->add($tripDay);

        // Freight Area
        // Select field
        // $freightArea = new Select(
        // 'freightArea',
        // FreightAreas::find(),
        // array(
        // 'using'		=> array('id', 'name'),
        // 'useEmpty'	=> true,
        // 'emptyTest'	=> '...',
        // 'emptyValue'=> '',
        // 'class'		=> 'form-control'
        // )
        // );
        // $freightArea->setLabel('Freight Area');
        // $this->add($freightArea);

        // Freight Carrier
        // Select field
        // $freightCarrier = new Select(
        // 'freightCarrier',
        // FreightCarriers::find(),
        // array(
        // 'using'		=> array('id', 'name'),
        // 'useEmpty'	=> true,
        // 'emptyTest'	=> '...',
        // 'emptyValue'=> '',
        // 'class'		=> 'form-control'
        // )
        // );
        // $freightCarrier->setLabel('Freight Carrier');
        // $this->add($freightCarrier);

        // Customer status
        // Select field
        $status = new Select(
            'status',
            CustomerStatus::find(),
            array(
                'using'		=> array('id', 'name'),
                'class'		=> 'form-control',
                'required'		=> 'true'
            )
        );
        $defaultStatus = CustomerStatus::findFirst("name = 'Normal'");
        $status->setDefault($defaultStatus->id);
        $status->setLabel('Status');
        $this->add($status);

        // Customer status
        // Select field
        $salesArea = new Select(
            'salesArea',
            SalesAreas::find([
                'order' => 'ordering ASC',
            ]),
            array(
                'using'		=> array('id', 'name'),
                'class'		=> 'form-control',
                'useEmpty'	=> true,
                'emptyTest'	=> '',
                'emptyValue'=> '',
                'required'		=> 'true',
            )
        );
        $salesArea->setLabel("Sales Area");
        $this->add($salesArea);
    }
}
