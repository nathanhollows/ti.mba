<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Addresses extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $customerCode;

    /**
     *
     * @var int
     */
    public $typeCode;

    /**
     *
     * @var string
     */
    public $line1;

    /**
     *
     * @var string
     */
    public $line2;

    /**
     *
     * @var string
     */
    public $line3;

    /**
     *
     * @var string
     */
    public $suburb;

    /**
     *
     * @var string
     */
    public $zipCode;

    /**
     *
     * @var string
     */
    public $city;

    /**
     *
     * @var string
     */
    public $country;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasOne('typeCode', 'App\Models\AddressTypes', 'typeCode', array('alias' => 'type'));
    }

    // Encode address as Google Maps URL
    public function getGoogleMapsUrl()
    {
        $url = "https://www.google.com/maps?q=";
        if ($this->line1) {
            $url = $url . str_replace(" ", "+", $this->line1) . "+";
        }
        if ($this->city) {
            $url = $url . str_replace(" ", "+", $this->city) . "+";
        }
        return $url;
    }

    // Encode address as QR code generating URL
    public function getQRUrl()
    {
        $url = "https://qrcode.tec-it.com/API/QRCode?data=https%3a%2f%2fwww.google.com%2fmaps%3fsaddr%3dMy%2bLocation%26daddr%3d";
        if ($this->line1) {
            $url = $url . str_replace(" ", "%2520", $this->line1) . "%2520";
        }
        if ($this->city) {
            $url = $url . str_replace(" ", "%2520", $this->city) . "%2520";
        }
        return $url;
    }
}
