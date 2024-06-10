<?php

namespace App\Controllers;

use DataTables\DataTable;
use App\Models\Stock;
use Phalcon\Http\Response;

class StockController extends ControllerBase
{
    public function initialize()
    {
        $this->view->setTemplateBefore('private');
        parent::initialize();
    }

    /**
     * Index action
     * Shows the stock list and search
     * View: stock/index
     */
    public function indexAction()
    {
        $this->tag->prependTitle('Stock');

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
        $packet = Stock::findFirstByPacketNumber($packet);
        $this->tag->prependTitle(strtoupper($packet->packetNumber));
        $this->view->packet = $packet;
    }

    public function committedAction()
    {
        $this->tag->prependTitle('Committed Stock');

        $query = "
        SELECT
            grade,
            oi.width,
            oi.thickness,
            treatment,
            finish,
            SUM(CASE WHEN ot.length = 3.6 THEN ot.pieces ELSE 0 END) AS '3.6m',
            SUM(CASE WHEN ot.length = 4.8 THEN ot.pieces ELSE 0 END) AS '4.8m',
            SUM(CASE WHEN ot.length = 6.0 THEN ot.pieces ELSE 0 END) AS '6.0m',
            SUM(CASE WHEN ot.length = 7.2 THEN ot.pieces ELSE 0 END) AS '7.2m',
            GROUP_CONCAT(DISTINCT CASE WHEN ot.length NOT IN (3.6, 4.8, 6.0, 7.2) THEN CONCAT(ot.pieces, '/', FORMAT(ot.length, 1)) END ORDER BY ot.length SEPARATOR ', ') AS 'other',
            SUM(CASE WHEN ot.length IS NULL THEN oi.ordered ELSE 0 END) AS 'random',
            o.orderNumber,
            c.name AS 'customer',
            c.customerCode,
            o.date
        FROM orders o
            LEFT JOIN customers c ON o.customerCode = c.customerCode
            LEFT JOIN order_items oi ON o.orderNumber = oi.orderNo
            LEFT JOIN order_tallies ot ON oi.orderNo = ot.orderNumber AND oi.itemNo = ot.itemNumber
        WHERE o.complete = 0
            AND oi.width IS NOT NULL AND oi.width <> 0
            AND oi.thickness IS NOT NULL AND oi.thickness <> 0
        GROUP BY o.date, oi.width, oi.thickness, treatment, finish, grade
        ORDER BY 
            CASE WHEN treatment = 'H6' THEN 1 ELSE 0 END,
            oi.thickness, 
            oi.width;
        ";

        $result = $this->db->query($query);
        $stockOnOrder = $result->fetchAll(\Phalcon\Db\Enum::FETCH_ASSOC);

        $this->view->stockOnOrder = $stockOnOrder;

        $grades = [];

        // Sort the array as above but only iterate through the stockOnOrder array once
        foreach ($stockOnOrder as $row) {
            // Format date to be more readable
            $row['formattedDate'] = date('d/m/y', strtotime($row['date']));
            // Calculate the age of the order
            $row['age'] = date_diff(date_create($row['date']), date_create('now'))->format('%a');
            if ($row['grade'] == "RCM") {
                $clearsGrade[] = $row;
            } elseif (($row['grade'] == "RNO1" || $row['grade'] == "RSG8" || $row['grade'] == "RWNO1" || $row['grade'] == "RSG6") && $row['finish'] == "S") {
                $pineSawn[] = $row;
            } elseif (($row['grade'] == "RNO1" || $row['grade'] == "RSG8" || $row['grade'] == "RWNO1") && ($row['finish'] != "S" && $row['finish'] != "B4S")) {
                $pineDressed[] = $row;
            } elseif (($row['grade'] == "RNO1" || $row['grade'] == "RSG8" || $row['grade'] == "RWNO1") && $row['finish'] == "B4S") {
                $pineBandSawn[] = $row;
            } elseif ($row['grade'] == "RTSG8" && $row['treatment'] == "H12" && $row['finish'] != "B4S") {
                $kingfisherSG8[] = $row;
            } elseif ($row['grade'] == "RTSG8" && $row['treatment'] == "H31" && $row['finish'] != "B4S") {
                $kingfisherSG8H31[] = $row;
            } elseif ($row['grade'] == "RTSG8" && $row['treatment'] == "H32" && $row['finish'] != "B4S") {
                $kingfisherSG8H32[] = $row;
            } elseif ($row['grade'] == "RTSG8" && $row['finish'] == "B4S") {
                $kingfisherSG8BS4[] = $row;
            } elseif ($row['grade'] == "RTSG10") {
                $kingfisherSG10[] = $row;
            } elseif ($row['grade'] == "SPR8" && $row['finish'] != "B4S") {
                $kingfisherSpruceSG8[] = $row;
            } elseif (($row['grade'] == "SPR10" || $row['grade'] == "SPR12")) {
                $kingfisherSpruce1012[] = $row;
            } elseif (($row['grade'] == "SPR8" || $row['grade' == "SPR10" || $row['grade'] == "SPRUCE"]) && ($row['finish'] == "B4S" || $row['finish'] == "BS4")) {
                $kingfisherSpruceBS4[] = $row;
            } elseif (($row['grade'] == "SPRUCE")) {
                $kingfisherSpruce[] = $row;
            } else {
                $other[] = $row;
            }
        }

        $grades['Clears / RCM'] = $clearsGrade;
        $grades['WEKA SG8 / No1 Rough Sawn'] = $pineSawn;
        $grades['WEKA SG8 / No1 Dressed'] = $pineDressed;
        $grades['WEKA SG8 / No1 B4S'] = $pineBandSawn;
        $grades['Kingfisher SG8 H1.2 Boron (Pink)'] = $kingfisherSG8;
        $grades['Kingfisher SG8 H3.1 LOSP (Clear)'] = $kingfisherSG8H31;
        $grades['Kingfisher SG8 H3.2 CCA (Green)'] = $kingfisherSG8H32;
        $grades['Kingfisher SG8 B4S'] = $kingfisherSG8BS4;
        $grades['Kingfisher SG10'] = $kingfisherSG10;
        $grades['Kingfisher Spruce SG8'] = $kingfisherSpruceSG8;
        $grades['Kingfisher Spruce SG10 / SG12'] = $kingfisherSpruce1012;
        $grades['Kingfisher Spruce BS4'] = $kingfisherSpruceBS4;
        $grades['Kingfisher Spruce'] = $kingfisherSpruce;
        $grades['Other'] = $other;

        $this->view->grades = $grades;
    }

    /**
     * Search action
     * Shows the stock list and search
     * View: stock/search
     */
    public function searchAction()
    {
        $this->tag->prependTitle('Search Stock');

        if ($this->request->hasQuery("width")) {
            $this->view->disable();

            $stock = new Stock;
            $stockSearch = $stock->searchStockFromRequest($this->request);
            $dataTables = new DataTable();
            $dataTables->fromBuilder($stockSearch);

            $response = new Response();
            $response->setJsonContent($dataTables->getResponse());
            $response->send();

            $this->persistent->parameters = null;
        }
    }

    /**
     * CheckInStock action
     * Returns a boolean value if the stock is in stock
     * 
     */
    public function checkInStockAction()
    {
        // Check if the request has a width parameter, as a basic check
        if ($this->request->hasQuery("width")) {
            $this->view->disable();
            $stock = new Stock;
            $stockCheck = $stock->checkStockFromRequest($this->request);

            $response = new Response();
            $response->setJsonContent($stockCheck->getQuery()->execute()[0]);
            $response->send();
        }
    }
}
