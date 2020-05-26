<?php

namespace App\Controllers;

use Phalcon\Tag;
use Phalcon\Http\Response;
use App\Models\SurveyResults;
use App\Models\Contacts;

class SurveyController extends ControllerBase
{
    public function initialize()
    {
        parent::initialize();
    }

    public function indexAction($name = null)
    {
        $this->tag->prependTitle('ATS Survey ' . date('Y'));

        $contact = Contacts::findFirstBywebId($name);
        if (!$contact) {
            $response = new Response();
            return $response->redirect('survey/error');
        }
        if (SurveyResults::findFirstByContact($contact->id)) {
            $response = new \Phalcon\Http\Response();
            return $response->redirect('survey/thankyou');
        }
        $this->view->contact = $contact;

        $this->view->scale = array(
            1   => 'radio-danger',
            2   => 'radio-warning',
            3   => '',
            4   => 'radio-info',
            5   => 'radio-success',
        );

        $this->view->questions = array(
            '1' => 'Does the quality of our products meet your expectations',
            '2' => 'Do we deliver in full, on time, in spec',
            '3' => 'Rate our quote responses and follow up times',
            '4' => 'Rate our phone performance',
            '5' => 'Rate our product range',
            '6' => 'Rate our resources e.g. timber book, sku lists, samples, and technical expertise',
            '7' => 'Rate how ATS Timber deal with service and quality issues',
            '8' => 'Rate our overall service performance',
        );
    }

    public function submitAction()
    {
        $response = new \Phalcon\Http\Response();
        if ($this->request->isPost()) {
            $result = new SurveyResults();
            $result->assign($this->request->getPost());
            if (!$result->save()) {
                return $response->redirect('survey/error');
            } else {
                $response = new \Phalcon\Http\Response();
                return $response->redirect('survey/thankyou');
            }
        } else {
            return $response->redirect('survey/error');
        }
    }

    public function thankyouAction()
    {
        $this->tag->prependTitle('Thank you!');

        $this->view->count = SurveyResults::Count();
    }

    public function errorAction()
    {
        $this->tag->prependTitle('404');
    }
}
