<?php

namespace App\Forms\Quotes;

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
use App\Models\PricingUnit;
use App\Models\QuoteCodes;

class ItemForm extends Form
{

    // Initialize the form
    public function initialize()
    {

        // Hidden ID to be used when editing items
        $id = new Hidden("id");
        $this->add($id);

        $quoteId = new Hidden("quoteId");
        $this->add($quoteId);

        $grade = new Select(
            'grade[]',
            Grade::find(array('conditions' => 'active = 1', 'order' => 'name ASC')),
            array(
                'using'	=> array('shortCode', 'name'),
                'useEmpty'	=> true,
                'emptyText'	=> 'Grade',
                'class'		=> 'data grade no-selectize data',
                'data-live-search'	=> 'true',
                'data-container'	=> 'body',
            )
        );
        $this->add($grade);

        // Numeric value for width
        $width = new Numeric('width[]');
        $width->setLabel('Width');
        $width->setAttributes(array(
            "class"	=> "form-control",
            "step"	=> "1",
            "placeholder"	=> "Width",
        ));
        $this->add($width);

        // Numeric value for thickness
        $thickness = new Numeric('thickness[]');
        $thickness->setLabel("Thickness");
        $thickness->setAttributes(array(
            "class"	=> "data",
            "step"	=> "1",
            "placeholder"	=> "Thickness",
        ));
        $this->add($thickness);

        // Numeric value for quantity
        $qty = new Numeric('qty[]');
        $qty->setLabel("Qty");
        $qty->setAttributes(array(
            "class"	=> "form-control",
            "step"	=> "1",
            "placeholder"	=> "Qty",
        ));
        $this->add($qty);

        // Select list containing all usable treatments
        $treatment = new Select(
            'treatment[]',
            Treatment::find(),
            array(
                'using' => array('shortCode', 'shortCode'),
                'useEmpty'	=> true,
                'class' => 'data treatment no-selectize data',
                'data-container' => 'body',
                'emptyText'	=> 'Treat...',
                'data-live-search' => 'true',
            )
        );
        $treatment->setLabel("Treatment");
        $this->add($treatment);

        // Select list containing all usable drynesses
        $dryness = new Select(
            'dryness[]',
            Dryness::find(),
            array(
                'using' => array('shortCode', 'shortCode'),
                'useEmpty'	=> true,
                'class' => 'data dryness no-selectize data',
                'data-container' => 'body',
                'emptyText'	=> 'Dry...',
                'data-live-search' => 'true',
            )
        );
        $dryness->setLabel("Dryness");
        $this->add($dryness);

        // Select list containing all usable finishes
        $finish = new Select(
            'finish[]',
            Finish::find(),
            array(
                'using' => array('id', 'name'),
                'useEmpty'	=> true,
                'class' => 'form-control no-selectize data',
                'data-container' => 'body',
                'emptyText'	=> 'Finish',
                'data-live-search' => 'true',
                'data-show-subtext'	=> 'true',
            )
        );
        $finish->setLabel("Finish");
        $this->add($finish);

        // Simple numeric value for price
        $price = new Numeric('price[]');
        $price 	->setLabel("Price")
                ->setAttributes(
                    array(
                    "class"		=> "form-control",
                    "step"		=> "any",
                    "placeholder"	=> "Price",
                )
                );
        $this->add($price);

        $priceMethod = new Select(
            'priceMethod[]',
            PricingUnit::find(),
            array(
                'using'	=> array('id', 'name'),
                'useEmpty'	=> false,
                'class'		=> 'form-control no-selectize data',
            )
        );
        $this->add($priceMethod);

        $priceMethod = new Select('priceMethod');

        $notes = new Text('lengths[]');
        $notes->setAttributes(
            array(
                'class'	=> 'form-control no-selectize data',
                'placeholder'	=> 'Notes',
            )
        );
        $this->add($notes);
    }
}
