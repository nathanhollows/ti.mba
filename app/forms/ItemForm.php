<?php

namespace App\Forms;

// Use form elements
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Hidden;
use Phalcon\Forms\Element\Submit;

// Use Models relating to items
use App\Models\Grade;
use App\Models\Treatment;
use App\Models\Finish;
use App\Models\Dryness;

class ItemForm extends Form
{

    // Initialize the form
    public function initialize()
    {

        // Hidden ID to be used when editing items
        $id = new Hidden("id");
        $this->add($id);

        // Numeric value for width
        $width = new Numeric('width');
        $width->setLabel('Width');
        $width->setAttributes(array(
            "class"	=> "form-control",
            "step"	=> "1",
        ));
        $this->add($width);

        // Numeric value for thickness
        $thickness = new Numeric('thickness');
        $thickness->setLabel("Thickness");
        $thickness->setAttributes(array(
            "class"	=> "form-control",
            "step"	=> "1",
        ));
        $this->add($thickness);

        // Select list containing all usable grades
        $grade = new Select(
            'grade',
            Grade::find(),
            array(
                'using' => array('id', 'name'),
                'required'	=> 'true',
                'useEmpty'	=> true,
                'class' => 'form-control select2'
            )
        );
        $grade->setLabel("Grade");
        $this->add($grade);

        // Select list containing all usable treatments
        $treatment = new Select(
            'treatment',
            Treatment::find(),
            array(
                'using' => array('id', 'name'),
                'required'	=> 'true',
                'useEmpty'	=> true,
                'class' => 'form-control select2'
            )
        );
        $treatment->setLabel("Treatment");
        $this->add($treatment);

        // Select list containing all usable drynesses
        $dryness = new Select(
            'dryness',
            Dryness::find(),
            array(
                'using' => array('id', 'name'),
                'required'	=> 'true',
                'useEmpty'	=> true,
                'class' => 'form-control select2'
            )
        );
        $dryness->setLabel("Dryness");
        $this->add($dryness);

        // Select list containing all usable finishes
        $finish = new Select(
            'finish',
            Finish::find(),
            array(
                'using' => array('id', 'name'),
                'required'	=> 'true',
                'useEmpty'	=> true,
                'class' => 'form-control select2'
            )
        );
        $finish->setLabel("Finish");
        $this->add($finish);

        // Simple numeric value for price
        $price = new Numeric('price');
        $price 	->setLabel("Price")
                ->setAttributes(
                    array(
                    "class"		=> "form-control",
                    "step"		=> "any",
                )
                );
        $this->add($price);

        $priceMethod = new Select('priceMethod');

        $qty = new Numeric('qty');
        $qty 	->setLabel("qty")
                ->setAttributes(
                    array(
                    "class"		=> "form-control",
                    "step"		=> "any",
                )
                );
        $this->add($qty);
    }
}
