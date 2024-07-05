<?php

namespace App\Models;

use Phalcon\Mvc\Model;

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
            'App\Models\TripStops',
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
}
