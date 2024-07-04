<?php

namespace App\Controllers;

use Phalcon\Security\Random;
use App\Models\Quotes;
use App\Models\QuoteItems;
use Knp\Snappy\Pdf;
use Phalcon\Http\Response;

class QuoteController extends ControllerBase
{
    public function getAction($webId)
    {
        $quote = Quotes::findFirstBywebId($webId);
        // $snappy = new Pdf('C:\"Program Files"\wkhtmltopdf\bin\wkhtmltopdf.exe');
        $snappy = new Pdf('/usr/bin/wkhtmltopdf');
        $snappy->setOptions(
            array(
                // 'header-html'	=> 'http://ats.ti.mba/quote/header',
                // 'header-spacing'=> '10',
                'footer-spacing' => '10',
                // 'margin-top'	=> '44',
                'margin-top'    => '0',
                'margin-bottom'    => '20',
                'margin-left'    => '0',
                'margin-right'    => '0',
                'page-size'        => 'A4',
                'disable-smart-shrinking'    => true,
                'dpi'            => '620',
            )
        );
        $response = new Response;
        // Setting a header by its name
        $response->setHeader("Content-Type", "application/pdf");
        $response->setHeader("Content-Disposition", 'inline; filename="Quote ' . $quote->quoteId . ' - ' . $quote->customer->name . '.pdf"');
        // Check if the application is running in a Docker container
        $inDocker = getenv('IN_DOCKER');
        if ($inDocker) {
            $url = $this->url->get('quote/public/')
                . $quote->webId;
        } else {
            $url = 'http://nginx:80/quote/header';
        }
        // Generate and send
        $response->setContent($snappy->getOutput($url));
        return $response->send();
    }

    public function publicAction($webId = null)
    {
        $quote = Quotes::findFirstBywebId($webId);
        $items = QuoteItems::find("quoteId = $quote->quoteId");

        if (!$quote) {
            // If the quote does not exist then send the user to a 404 page
            $this->response->redirect('error');
        }

        $this->tag->prependTitle('Quote');
        $this->view->setTemplateBefore('quote');
        $this->view->quote = $quote;
        $this->view->items = $items;
        $this->view->dated  = strtotime($quote->date);
    }

    public function headerAction()
    {
        $this->view->setTemplateBefore("none");
    }

    public function footerAction()
    {
        $this->view->setTemplateBefore("none");
    }
}
