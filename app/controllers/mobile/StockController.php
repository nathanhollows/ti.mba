<?php

namespace App\Controllers\Mobile;

use App\Models\Orders;
use App\Models\Packets;
use App\Models\PacketHistory;
use App\Models\PacketTallies;
use DataTables\DataTable;
use Phalcon\Http\Response;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Paginator\Adapter\Model as Paginator;

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
            ->columns('packetHistory.packetNumber, width, thickness, finWidth, finThickness, grade, treatment, dryness, dryness.dry, finish, finish.machined, onsite, lineal, cube')
            ->from('App\Models\Packets')
            ->join('App\Models\PacketHistory', 'lastId = packetHistory.id', 'packetHistory')
            ->join('App\Models\Dryness', 'dryness =dryness.shortCode', 'dryness')
            ->join('App\Models\Finish', 'finish = finish.shortCode', 'finish')
            ->where('current = 1')
            ->groupBy(['packetHistory.packetNumber'])
            ->orderBy('dryness DESC, finThickness ASC, finWidth ASC');

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
            $this->persistent->parameters = null;
        };

        $this->assets->collection('header')
            ->addCss('https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css', false);
        $this->assets->collection('footer')
            ->addJs('https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js', false)
            ->addJs('https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js');
    }
}
