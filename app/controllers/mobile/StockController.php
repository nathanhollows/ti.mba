<?php

namespace App\Controllers\Mobile;

use App\Models\Dryness;
use App\Models\Finish;
use App\Models\Orders;
use App\Models\Stock;
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
            ->columns('packetHistory.packetNo, width, thickness, finishWidth, finishThickness, grade, treatment, dryness, finish, linealTally, netCube, offsite')
            ->from(Stock::class)
            ->innerJoin(PacketHistory::class, 'lastId = packetHistory.id', 'packetHistory')
            ->where('current = 1 AND packetHistory.packetNo NOT LIKE \'%X\'')
            ->orderBy('dryness DESC, finishThickness ASC, finishWidth ASC');

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
