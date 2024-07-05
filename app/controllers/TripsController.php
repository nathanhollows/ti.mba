<?php

namespace App\Controllers;

use App\Models\Customers;
use App\Models\SalesAreas;
use App\Models\Trips;
use App\Models\TripStops;

class TripsController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
        $this->view->mapBoxKey = $this->config->mapbox->apiKey;
    }

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->tag->setTitle('Trips');
    }

    /**
     * Planner action
     *
     * @return void
     */
    public function plannerAction()
    {
        $this->tag->prependTitle('Trip Planner');

        $customers = new Customers;
        $this->view->customers = $customers->getActiveSortedBySalesArea();
        $this->view->incomplete = $customers->getActiveNoSalesArea();
        $salesAreas = new SalesAreas;
        $this->view->salesAreas = $salesAreas->tripPlannerQuery();
        $this->view->name = $this->auth->getIdentity()['name'];
        $this->view->trips = Trips::find();
    }

    /**
     * Save a trip
     */
    public function saveAction()
    {
        if (!$this->request->isPost()) {
            $this->flashSession->error('Invalid request');
            $this->_redirectBack();
        }

        $trip = new Trips();
        $trip->name = $this->request->getPost('name');

        // Verify the trip name is unique
        if (Trips::findFirstByName($trip->name)) {
            $this->flashSession->error('Trip name must be unique');
            $this->_redirectBack();
        }

        if (!$trip->save()) {
            foreach ($trip->getMessages() as $message) {
                $this->flashSession->error((string) $message);
            }
        } else {
            $this->flashSession->success('Trip was created successfully');
        }

        $customers = $this->request->getPost('customerCode');
        if ($customers) {
            $counter = 1;
            foreach ($customers as $customer) {
                $tripStop = new TripStops();
                $tripStop->tripId = $trip->id;
                $tripStop->ordering = $counter;
                $tripStop->customerCode = $customer;
                $message = $tripStop->save();
                foreach ($tripStop->getMessages() as $message) {
                    $this->flashSession->error((string) $message);
                }
                $counter++;
            }
        }

        $this->response->redirect('trips/view/' . $trip->niceName);
    }

    /**
     * View a trip
     */
    public function viewAction($niceName)
    {
        $trip = Trips::findFirstByNiceName($niceName);
        if (!$trip) {
            $this->flashSession->error('Trip not found');
            $this->_redirectBack();
        }

        $this->view->trip = $trip;
    }

    /**
     * Delete a trip
     */
    public function deleteAction($niceName)
    {
        $trip = Trips::findFirstByNiceName($niceName);
        if (!$trip) {
            $this->flashSession->error('Trip not found');
            $this->_redirectBack();
            return;
        }

        if (!$trip->delete()) {
            foreach ($trip->getMessages() as $message) {
                $this->flashSession->error((string) $message);
            }
        } else {
            $this->flashSession->success('Trip was deleted successfully');
        }

        $this->response->redirect('trips/planner');
    }
}
