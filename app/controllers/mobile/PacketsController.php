<?php

namespace App\Controllers\Mobile;

use App\Models\Packets;

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

    public function viewAction($packetNumber = null)
    {
        $this->tag->prependTitle('Packet');

        $packet = Packets::findFirst([
            'conditions'    => 'packetNumber = ?1',
            'bind'  => [
                1 => $packetNumber
            ]
        ]);
        $this->view->pageTitle = strtoupper($packet->packetNumber);
        $this->view->packet = $packet;
    }
}
