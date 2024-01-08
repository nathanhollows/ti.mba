<?php

namespace App\Controllers\Mobile;

use App\Models\Stock;

class PacketsController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize();
    }

    public function indexAction()
    {
        $this->tag->prependTitle('Packet');
        $this->view->pageTitle = "Scheduled Orders";
    }

    public function viewAction($packetNo = null)
    {
        $this->tag->prependTitle('Packet');

        $packet = Stock::findFirst([
            'conditions'    => 'packetNo = ?1',
            'bind'  => [
                1 => $packetNo
            ]
        ]);
        $this->view->pageTitle = strtoupper($packet->packetNo);
        $this->view->packet = $packet;
    }
}
