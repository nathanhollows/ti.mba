<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\Numeric;

use App\Models\Users;
use App\Models\HotlistTypes;
use App\Models\HotlistCategories;

class HotlistForm extends Form
{

    /**
     * Initialize the products form
     */
    public function initialize($entity = null, $options = array())
    {

        $title = new Text('title');
        $title->setAttributes(array(
            "placeholder"   => "Henderson Bridge Job",
            "class"         => "form-control",
            "required"      => "true",
        ));
        $title->setLabel('Name of Job');

        $customer = new Text('customer');
        $customer->setAttributes(array(
            "placeholder"   => "Carters Henderson",
            "class"         => "form-control",
            "required"      => "true",
        ));
        $customer->setLabel('Customer / Contractor');

        $amount = new Numeric('value');
        $amount->setLabel('Value ($)');
        $amount->setAttributes(array(
            "class" => "form-control",
            "placeholder" => "Estimated Value",
            "step"  => "any",
            "required"      => "true",
        ));

        $description = new TextArea('description');
        $description->setLabel('Description of Job');
        $description->setAttributes(array(
            'class' => 'form-control',
            'placeholder' => 'Details of the job',
            "required"      => "true",
        ));

        $type = new Select(
            'type',
            HotlistTypes::find(),
            array(
                'using' => array(
                    'id',
                    'name',
                ),
                'class' => 'form-control primary',
            )
        );
        $type->setLabel('Quoted Via');

        $category = new Select(
            'category',
            HotlistCategories::find(),
            array(
                'using' => array(
                    'id',
                    'name',
                ),
                'class' => 'form-control primary',
            )
        );
        $category->setLabel('Category');

        $this->add($title);
        $this->add($description);
        $this->add($customer);
        $this->add($amount);

    }
}
