<?php

namespace App\Controllers;

use App\Models\SalesAreas;
use App\Models\Users;

class SettingsController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        if ($this->request->isPost()) {
            $salesAreas = SalesAreas::find();
            foreach ($salesAreas as $area) {
                $area->agent = $this->request->getPost('area' . $area->id, 'int');
                $area->update();
            }
        }

        // In event of update, we fetch again to avoid inconsistent representation
        $salesAreas = SalesAreas::find();
        $this->tag->prependTitle('Settings');
        $this->view->salesAreas = $salesAreas;
        $this->view->reps = Users::getActive();
    }
}
