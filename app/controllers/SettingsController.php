<?php

namespace App\Controllers;

use App\Models\SalesAreas;
use App\Models\Users;

class SettingsController extends ControllerBase
{
    public function initialize()
    {
        $user = $this->auth->getUser();
        if ($user->administrator != 1) {
            $this->flashSession->error("You don't have permission to access the Settings module");
            return $this->response->redirect('dashboard');
        }
        $this->view->developer = $user->developer == 1;
        $this->view->setTemplateBefore('private');
    }
    
    public function indexAction()
    {
        $this->tag->prependTitle('Settings');
    }
    
    public function salesareasAction()
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
        $salesAreas = SalesAreas::find([
            'order' => 'ordering ASC'
        ]);
        $this->tag->prependTitle('Sales Areas');
        $this->view->salesAreas = $salesAreas;
        $this->view->reps = Users::getActive();
    }
    
    public function clearcacheAction($cache)
    {
        if (!$this->view->developer) {
            $this->flashSession->error('You do not have permission to clear the cache');
            return $this->response->redirect('settings');
        }
        $cacheDir = $this->di->getShared('config')->path('application.cacheDir');
        
        switch ($cache) {
            case 'models':
                $cacheDir .= 'modelsCache/';
                break;
            case 'metadata':
                $cacheDir .= 'metaData/';
                break;
            case 'volt':
                $cacheDir .= 'volt/';
                break;
            default:
            $this->flashSession->error('Invalid cache type');
            return $this->response->redirect('settings');
        }
        
        $files = glob($cacheDir . '*');
        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
        
        
        $this->view->disable();
        $this->flashSession->success('Cache cleared');
        return $this->response->redirect('settings');
    }
    
}