<?php

namespace App\Controllers\Mobile;

use App\Models\Stock;

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
     * @param  App\Models\Packet packetNo string $packet
     */
    public function viewAction($packet = null)
    {
        $packet = Stock::findFirst([
            'conditions'    => 'packetNo = ?1',
            'bind'          => [
                1   => $packet
            ],
        ]);
    }
}
