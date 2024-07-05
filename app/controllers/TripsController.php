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

        $tripName = $this->request->getPost('name', 'string');
        $id = $this->request->getPost('id', 'string', null);

        try {
            $trip = Trips::saveTrip($tripName, $id, $this->request->getPost('customerCode'));
            $this->flashSession->success('Trip saved successfully');
            $this->response->redirect('trips/view/' . $trip->niceName);
        } catch (\Exception $e) {
            $this->flashSession->error($e->getMessage());
            $this->_redirectBack();
        }
    }

    /**
     * View a trip
     */
    public function viewAction($niceName)
    {
        $trip = Trips::findFirstByNiceName($niceName);
        if (!$trip) {
            $this->flashSession->error('Trip not found');
            $this->response->redirect('trips');
        }

        $this->view->trip = $trip;
        $this->tag->prependTitle($trip->name);

        $salesAreas = new SalesAreas;
        $this->view->salesAreas = $salesAreas->tripPlannerQuery();
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
