<?php

namespace App\Forms;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Submit;

class KpiForm extends Form
{
    // Initialize the Follow Up form
    public function initialize($entity = null, $option = null)
    {
        $chargeout = new Numeric('chargeOut');
        $chargeout->setLabel('Charge Out (MTD)');
        $chargeout->setAttributes(array(
            'class'	=> 'form-control',
            'required'	=> 'true',
            'step'	=> 'any'
        ));
        $this->add($chargeout);

        $truck = new Text('truckTime');
        $truck->setLabel('Truck Time');
        $truck->setAttributes(array(
            'class'	=> 'form-control',
            'required'	=> 'true',
            'rows'	=> 1,
        ));
        $this->add($truck);

        $onsite = new Numeric('onsiteDispatch');
        $onsite->setLabel('Onsite Dispatch');
        $onsite->setAttributes(array(
            'class'	=> 'form-control',
            'required'	=> 'true',
            'step'	=> 'any'
        ));
        $this->add($onsite);

        $offsite = new Numeric('offsiteDispatch');
        $offsite->setLabel('Offsite Dispatch');
        $offsite->setAttributes(array(
            'class'	=> 'form-control',
            'required'	=> 'true',
            'step'	=> 'any'
        ));
        $this->add($offsite);

        $ordersSent = new Numeric('ordersSent');
        $ordersSent->setLabel('Orders Sent');
        $ordersSent->setAttributes(array(
            'class'	=> 'form-control',
            'required'	=> 'true',
        ));
        $this->add($ordersSent);
    }
}
