<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\Check;
use Phalcon\Forms\Element\Numeric;

use App\Models\Users;

class DailySalesForm extends Form
{

    /**
     * Initialize the products form
     */
    public function initialize($entity = null, $options = array())
    {
        $id = new Hidden('id[]');
        $this->add($id);

        $rep = new Select(
            "rep[]",
            Users::getActive(),
            array(
                'using' => array(
                    'id',
                    'name',
                ),
                'class' => 'data',
                'useEmpty'  => true,
                'emptyValue'    => 'Sales Rep',
            )
        );
        $this->add($rep);

        $quoted = new Check('quoted[]', array('value' => 1));
        $this->add($quoted);

        $useDate = date('Y-m-d');

        $date = new Hidden('date');
        $date->setDefault($useDate);
        $this->add($date);

        $customerRef = new Text('customerReference[]');
        $customerRef->setAttributes(array(
            "placeholder"   => "Customer Reference",
            "class"         => "data",
        ));
        $this->add($customerRef);

        $amount = new Numeric('amount[]');
        $amount->setLabel('Value');
        $amount->setAttributes(array(
            "class" => "data",
            "placeholder" => "Value",
            "step"  => "any",
        ));
        $this->add($amount);
    }
}
