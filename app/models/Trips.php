<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Models\TripStops;

/**
 * Trips
 *
 * Model for trips
 *
 * @package App\Models
 * @property int id
 * @property string name
 * @property string niceName
 *
 */
class Trips extends Model
{
    /**
     *
     * @var int
     */
    public $id;

    /**
     *
     * @var string
     */
    public $name;

    /**
     *
     * @var string
     */
    public $niceName;

    /**
     * Set relationships for the model
     */
    public function initialize()
    {
        $this->hasMany(
            'id',
            TripStops::class,
            'tripId',
            [
                'alias' => 'stops',
                'reusable' => true,
                'foreignKey' => [
                    'action' => Model\Relation::ACTION_CASCADE
                ],
                'params' => [
                    'order' => 'ordering ASC'
                ]
            ]
        );
    }

    /**
     * Before saving the record, set or update the nice name
     * Ensure the nice name is unique
     */
    public function beforeSave()
    {
        // Generate the nice name by replacing non-alphanumeric characters with dashes
        $this->niceName = preg_replace('/[^a-z0-9]+/', '-', strtolower($this->name));

        // Ensure the nice name is unique
        $baseNiceName = $this->niceName;

        // Check for existing records with the same nice name
        $existing = Trips::findFirst([
            'conditions' => 'niceName = :niceName: AND id != :id:',
            'bind' => [
                'niceName' => $this->niceName,
                'id' => $this->id ?? 0
            ]
        ]);
        if ($existing) {
            // Append a random counter to the nice name if it already exists
            $this->niceName = $baseNiceName . '-' . rand(3000, 9999);
        }
    }

    /**
     * saveTrip is a static method that creates a new trip record
     * @param string $name
     * @return Trips
     */
    public static function saveTrip($name, $id = null, $customers = [])
    {
        // Check for an existing trip with the same name
        $trip = Trips::findFirstById($id);

        // If the trip does not exist, create a new record
        if (!$trip) {
            $trip = new Trips();
        }

        $trip->name = $name;

        if (!$trip->save()) {
            throw new \Exception(implode(', ', $trip->getMessages()));
        }

        // Update trip stops
        if ($customers) {
            try {
                $trip->updateStops($customers);
            } catch (\Exception $e) {
                throw new \Exception($e->getMessage());
            }
        }

        return $trip;
    }

    /**
     * Update the trip stops
     * @param array $customers
     */
    public function updateStops($customers)
    {
        // Remove existing stops
        TripStops::removeStopsForTrip($this->id);

        // Add new stops
        $ordering = 1;
        foreach ($customers as $customer) {
            $stop = new TripStops();
            $stop->tripId = $this->id;
            $stop->customerCode = $customer;
            $stop->ordering = $ordering;
            if (!$stop->save()) {
                throw new \Exception(implode(', ', $stop->getMessages()));
            }
            $ordering++;
        }
    }
}
