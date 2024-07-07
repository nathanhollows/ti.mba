<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use Algolia\AlgoliaSearch\SearchClient;

class Contacts extends Model
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
     * @var string
     */
    public $name;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var string
     */
    public $directDial;

    /**
     *
     * @var string
     */
    public $cellPhone;

    /**
     *
     * @var string
     */
    public $position;


    /**
     *
     * @var int
     */
    public $role;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
        $this->hasMany('id', 'App\Models\ContactRecords', array('alias' => 'history'));
        $this->hasOne('role', 'App\Models\ContactRoles', 'id', array('alias'  => 'job'));
    }

    /**
     * Clear custom position on update
     * Contact role is required instead
     */
    public function beforeUpdate()
    {
        $this->position = null;
    }

    /**
     * Find contacts by customer code
     * @param  string $customerCode
     * @return array
     */
    public static function findByCustomerCode($customerCode)
    {
        $query = self::query();
        $query->where('customerCode = :customerCode:');
        $query->bind(['customerCode' => $customerCode]);
        return $query->execute();
    }

    public static function searchColumns($search)
    {
        $query = self::query();
        $query->where('name LIKE :search: OR directDial LIKE :search:');
        $query->orderBy('customerCode ASC');
        $query->bind(['search' => '%' . $search . '%']);
        return $query->execute();
    }

    /**
     * After save
     * Update algolia index if configured
     */
    public function afterSave()
    {
        // Update Algolia index
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('contacts');
            $record = [
                'objectID' => $this->id,
                'name' => $this->name,
                'email' => $this->email,
                'directDial' => $this->directDial,
                'cellPhone' => $this->cellPhone,
                'position' => $this->position,
                'role' => $this->job->name,
                'company' => $this->company->name,
                'customerCode' => $this->customerCode,
            ];
            $index->saveObject($record, ['autoGenerateObjectIDIfNotExist' => true]);
        }
    }

    /**
     * After delete
     * Update Algolia index if configured
     * 
     */
    public function afterDelete()
    {
        // Update Algolia index
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('contacts');
            $index->deleteObject($this->id);
        }
    }

    /**
     * Push all customers to Algolia
     * 
     */
    public static function pushToAlgolia()
    {
        $config = \Phalcon\DI::getDefault()->get('config');
        if ($config->algolia->appID != '') {
            $algolia = SearchClient::create($config->algolia->appID, $config->algolia->appKey);
            $index = $algolia->initIndex('contacts');
            $contacts = self::find();
            $records = [];
            foreach ($contacts as $contact) {
                $record = [
                    'objectID' => $contact->id,
                    'name' => $contact->name,
                    'email' => $contact->email,
                    'directDial' => $contact->directDial,
                    'cellPhone' => $contact->cellPhone,
                    'position' => $contact->position,
                    'role' => $contact->job->name,
                    'company' => $contact->company->name,
                    'customerCode' => $contact->customerCode,
                ];
                $records[] = $record;
            }
            $index->saveObjects($records, ['autoGenerateObjectIDIfNotExist' => true]);
        }
    }
}
