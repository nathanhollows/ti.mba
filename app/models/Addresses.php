<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Phalcon\Di;

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
     *
     * @var string
     */
    public $lat;

    /**
     *
     * @var string
     */
    public $lng;

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

    public function geocode()
    {
        $di = Di::getDefault();
        $config = $di->get('config')->maps;
        $addressParts = [];

        if ($this->line1) {
            $addressParts[] = str_replace(" ", "+", $this->line1);
        }
        if ($this->line2) {
            $addressParts[] = str_replace(" ", "+", $this->line2);
        }
        if ($this->line3) {
            $addressParts[] = str_replace(" ", "+", $this->line3);
        }
        if ($this->city) {
            $addressParts[] = str_replace(" ", "+", $this->city);
        }

        $address = implode(",+", $addressParts);

        if (!empty($config->googleAPI)) {
            // Geocode address using Google API
            $googleAPI = $config->googleAPI;
            $url = "https://maps.googleapis.com/maps/api/geocode/json?address=" . $address . "&key=" . $googleAPI;
        } else {
            // Geocode address using Mapbox API
            $mapboxAPI = $config->mapboxAPI;
            $url = "https://api.mapbox.com/search/geocode/v6/forward?q=" . $address . "&limit=1&access_token=" . $mapboxAPI;
        }

        $response = file_get_contents($url);
        $data = json_decode($response);

        if (isset($data->results) && count($data->results) > 0) {
            $this->lng = $data->results[0]->geometry->location->lng;
            $this->lat = $data->results[0]->geometry->location->lat;
            return true;
        } elseif (isset($data->features) && count($data->features) > 0) {
            $this->lng = $data->features[0]->geometry->coordinates[0];
            $this->lat = $data->features[0]->geometry->coordinates[1];
            return true;
        }

        throw new \Exception("Geocoding failed");
    }
}
