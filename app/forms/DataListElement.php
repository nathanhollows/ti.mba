<?php

namespace App\Forms;

use Phalcon\Forms\Element\AbstractElement;

class DataListElement extends AbstractElement
{
    public function  __construct($name, array $attributes = null)
    {
        parent::__construct($name, $attributes);
    }

    public function render($attributes = null): string
    {
        if (is_array($attributes)) {
            $this->attributes = array_merge($this->attributes, $attributes);
        }

        if (isset($this->attributes[0]['required'])) {
            $this->setName($this->attributes['required'] = true);
        }

        $inputAttributes = $this->getAttributes()[0] ?? [];
        $listData = $this->getAttributes()[1] ?? [];
        $fields = $this->getAttributes()[2] ?? [];
        $name = $inputAttributes['name'] ?? '';
        $this->setName($name);

        // Build the HTML for the input element. We're respecting the 'required' attribute if it's set in the attributes.
        $html = "<input type='text' id='" . $this->getName() ."' name='" . $this->getName() ."' list='list_" . $this->getName()."' ";
        foreach ($inputAttributes as $attr => $value) {
            $html .= $attr . "='" . htmlspecialchars($value, ENT_QUOTES) . "' ";
        }
        $html .= isset($inputAttributes['required']) && $inputAttributes['required'] ? "required " : "";
        $html .= ">";

        // Continue building the datalist part
        $html .= "<datalist id='list_" . $this->getName() ."'>";
        foreach ($listData as $option) {
            $valueField = $fields[1] ?? '';
            $dataValueField = $fields[0] ?? '';

            // Assuming the object structure allows direct attribute access. Use appropriate methods if necessary.
            $html .= "<option value=\"" . htmlspecialchars($option->$valueField, ENT_QUOTES) . "\" data-value=\"" . htmlspecialchars($option->$dataValueField, ENT_QUOTES) . "\"></option>";
        }
        $html .= "</datalist>";

        return $html;
    }
}
