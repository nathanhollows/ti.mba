<?php

namespace App\Controllers;

use DataTables\DataTable;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Mvc\Model;
use Phalcon\Mvc\Forms;
use Phalcon\Http\Response;
use Phalcon\Paginator\Adapter\Model as Paginator;
use App\Models\Stock;
use App\Models\PacketHistory;
use App\Models\PacketTallies;

class StockController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Stock');

        $this->view->noHeader = true;

        if ($this->request->isAjax()) {
            $builder = $this->modelsManager->createBuilder()
            ->columns('packetHistory.packetNumber, width, thickness, grade, treatment, dryness, dry, finish, machined, onsite, cube, lineal')
            ->from('App\Models\Stock')
            ->join('App\Models\PacketHistory', 'lastId = packetHistory.id', 'packetHistory')
            ->join('App\Models\Dryness', 'dryness =dryness.shortCode', 'dryness')
            ->join('App\Models\Finish', 'finish = finish.shortCode', 'finish')
            ->where('current = 1')
            ->orderBy('dryness DESC, thickness ASC, width ASC');

            $dataTables = new DataTable();
            $dataTables->fromBuilder($builder)->sendResponse();
            $this->persistent->parameters = null;
        };

        $this->assets->collection('footer')
            // DataTables
            ->addJs('//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js')
            ->addJs('//cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js')
            // View specific JS
            ->addJs('js/datatables/stock.js');
    }

    public function packetsAction($packet = null)
    {
        $this->view->setTemplateBefore('blank');
        $packet = Stock::findFirstByPacketNumber($packet);
        $this->tag->prependTitle(strtoupper($packet->packetNumber));
        $this->view->packet = $packet;
        $this->view->pageTitle = $packet->packetNumber;
        $this->view->pageSubtitle = "<span class='label label-info'>FSC 100%</span>";
    }
}
