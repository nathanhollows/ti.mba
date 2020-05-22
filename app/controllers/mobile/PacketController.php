<?php

namespace App\Controllers\Mobile;

use App\Models\Packets;

class PacketsControllers extends ControllerBase
{
    /** Initialize parent */
    public function initialize()
    {
        parent::initialize();
    }

    /** I'm not sure what this should do yet */
    public function indexAction()
    {
    }

    /**
     * View packet details
     * @param  App\Models\Packet packetNumber string $packet
     */
    public function viewAction($packet = null)
    {
        $packet = Packets::findFirst([
            'conditions'    => 'packetNumber = ?1',
            'bind'          => [
                1   => $packet
            ],
        ]);
    }
}
