<?php

namespace App\Controllers\Mobile;

use App\Models\Stock;
use App\Models\PacketHistory;
use DataTables\DataTable;

class StockController extends ControllerBase
{
    /**
     * Initialize
     */
    public function initialize()
    {
        parent::initialize();
    }

    /** Lsit available actions */
    public function indexAction()
    {
        $this->tag->prependTitle('Stock');
        $this->view->pageTitle = "Stock";
    }

    /** Search through stock */
    public function searchAction()
    {
        $this->tag->prependTitle('Stock');
        $this->view->pageTitle = "Stock Search";

        if ($this->request->isAjax()) {
            $builder = $this->modelsManager->createBuilder()
                ->columns('packetHistory.packetNo, IF(finishWidth, finishWidth, width) as finishWidth, IF(finishThickness, finishThickness, thickness) as finishThickness, grade, treatment, dryness, finish, linealTally, netCube, offsite')
                ->from(Stock::class)
                ->innerJoin(PacketHistory::class, 'lastId = packetHistory.id', 'packetHistory')
                ->where('current = 1 AND packetHistory.packetNo NOT LIKE \'%X\'')
                ->orderBy(' finishWidth ASC, finishThickness ASC');

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
            $this->persistent->parameters = null;
        };

        $this->assets->collection('header')
            ->addCss('https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css', false);
        $this->assets->collection('footer')
            ->addJs('https://cdn.datatables.net/2.0.8/js/dataTables.js', false)
            ->addJs('https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap4.min.js');
    }
}
