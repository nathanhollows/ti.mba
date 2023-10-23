<?php

namespace App\Controllers;

use App\Models\SalesAreas;
use App\Models\Users;

class SettingsController extends ControllerBase
{
    public function initialize()
    {
        if ($this->auth->getUser()->administrator != 1) {
            $this->flashSession->error("You don't have permission to access the Settings module");
            return $this->response->redirect('dashboard');
        }
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }
    
    public function indexAction()
    {
        if ($this->request->isPost()) {
            $salesAreas = SalesAreas::find();
            foreach ($salesAreas as $area) {
                if ($this->request->hasPost('area' . $area->id)) {
                    $area->agent = $this->request->getPost('area' . $area->id, 'int');
                    $success = $area->update();
                    if (!$success) {
                        $this->flash->error('Could not update sales areas');
                        foreach ($area->getMessages() as $message) {
                            $this->flash->error($message);
                        }
                        break;
                    }
                }
            }
            $this->flash->success('Sales areas updated');
        }
        
        // In event of update, we fetch again to avoid inconsistent representation
        $salesAreas = SalesAreas::find();
        $this->tag->prependTitle('Settings');
        $this->view->salesAreas = $salesAreas;
        $this->view->reps = Users::getActive();
    }
}
