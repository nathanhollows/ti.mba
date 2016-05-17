<?php

namespace App\Controllers;

use App\Freight\Freight;
use App\Models\FollowUp;
use App\Models\Quotes;
use App\Models\Kpis;

class DashboardController extends ControllerBase
{
	public function initialize()
	{
        if ($this->session->has('auth-identity')) {
            $this->view->setTemplateBefore('private');
        }
        $this->tag->prependTitle('Dashboard');
        parent::initialize();
	}

    public function indexAction()
    {
        $config = include __DIR__ . "/../config/config.php";

        $tasks = new FollowUp;

        $this->view->kpis = Kpis::thisMonth();

        $this->view->overdue     = $tasks->getOverdue(10);
        $this->view->today       = $tasks->getToday(10);
        
        $this->view->parser = new \cebe\markdown\Markdown();
        
        $this->assets->collection('header')
            ->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');
        
        $this->assets->collection('footer')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.2/Chart.bundle.min.js')
            ->addJs('js/dashboard/charts.js');

        if ($config->pbt->enable) {
            $freight = new Freight;
            $this->view->pbt = $freight->downloadPBT();
            $this->view->pbt = $freight->importPBT();
        }

        $this->view->quotes = new Quotes();
    }
}