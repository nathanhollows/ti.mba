<?php

namespace App\Controllers;

use App\Auth\Auth;
use App\Models\Users;
use App\Models\ContactRecord;
use App\Models\Quotes;
use App\Models\DailySales;
use Phalcon\Mvc\Model\Query\Builder;

class ProfileController extends ControllerBase
{
	public function initialize()
	{
		$this->view->setTemplateBefore('private');
		parent::initialize();

        $this->assets->collection('header')
            ->addCss('css/bootstrap-markdown.min.css', true);
        $this->assets->collection('footer')
            ->addJs('js/to-markdown.js', true)
            ->addJs('js/bootstrap-markdown.js', true)
            ->addJs('js/markdown.js', true);
	}

	public function indexAction()
	{
		if ($this->request->isAjax()) {
			print_r($this->request->getPost());
		}

		$user = new Auth;
		$id = $user->getId();


		$user = Users::findFirstByid($id);

		$this->tag->prependTitle($user->name);
		$this->view->pageTitle = $user->name;

		$this->view->user = $user;

		$this->view->history = ContactRecord::find(array(
			'conditions'	=> 'user = ?1',
			'bind'			=> array(1 => $id),
			'order'			=> 'date DESC',
			'limit'			=> '30',
		));

		$this->view->topDay = DailySales::sum(array(
			'column'		=> 'value',
			'conditions'	=> "rep = $id",
			'group'			=> 'date',
			'order'			=> 'sumatory DESC',
			'limit'			=> '1',
		));

		$builder = new Builder();
		$this->view->topMonth = $builder
			->columns(array('topValue' => 'SUM(value)', 'month' => 'MONTH(date)', 'year' => 'YEAR(date)'))
			->from('App\Models\DailySales')
			->where("rep = $id")
			->groupBy(array('month', 'year'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$builder = new Builder();
		$this->view->topWeek = $builder
			->columns(array('topValue' => 'SUM(value)', 'week' => 'WEEK(date)', 'year' => 'YEAR(date)'))
			->from('App\Models\DailySales')
			->where("rep = $id")
			->groupBy(array('week', 'year'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$builder = new Builder();
		$this->view->topYear = $builder
			->columns(array('topValue' => 'SUM(value)', 'year' => 'YEAR(date)'))
			->addFrom('App\Models\DailySales', 's')
            ->join('App\Models\Calendar', 'c.calendarDate = s.date', 'c')
			->where("rep = $id")
			->groupBy(array('c.financialYear'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$builder = new Builder();
		$this->view->topWeek = $builder
			->columns(array('topValue' => 'SUM(value)', 'date', 'year' => 'YEAR(date)',  'week'))
			->from('App\Models\DailySales')
			->where("rep = $id")
			->groupBy(array('year', 'week'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$quotes = new Quotes();
		$this->view->quotes = $quotes->find(array(
			'columns'	=> ['count' => 'count(*)'],
			'conditions'	=> 'month(date) = month(now()) AND year(date) = year(now()) AND user = ?1',
			'bind'		=> [1 => $id ],
		));
		$this->view->wonQuotes = $quotes->find(array(
			'columns'	=> ['count' => 'count(*)'],
			'conditions'	=> 'month(date) = month(now()) AND year(date) = year(now()) AND sale = 1 AND user = ?1',
			'bind'		=> [1 => $id ],
		));


		$this->view->sales = DailySales::sum(array(
			'column'		=> 'value',
			'conditions'	=> "rep = $id",
			'group'			=> 'date',
			'limit'			=> '20',
		));

		$this->view->headerButton = '<a href="/preferences/" type="button" class="btn btn-default pull-right"><i class="fa fa-icon fa-cog"></i> Preferences</a>';

		$this->view->graph = true;

		$this->assets->collection('footer')
			->addJs('/js/customers/customers.js')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.2/Chart.bundle.min.js');

        $this->assets->collection('header')
            ->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');

	}

	public function viewAction($id = null)
	{
		if ($this->request->isAjax()) {
			print_r($this->request->getPost());
		}

		$this->view->pick('profile/index');

		if (!$id) {
			$user = new Auth;
			$id = $user->getId();
		}

		$user = Users::findFirstByid($id);

		if ($user->profilesId == 0) {
			echo '
				<div class="panel panel-default">
					<div class="panel-body">
						<h4> This user is disabled </h4>
					</div>
				</div>
			';
			$this->view->pick('index');
		}

		$this->view->pageTitle = $user->name;
		$this->view->pageSubtitle = 'Profile';
		$this->tag->prependTitle($user->name);

		$this->view->user = $user;

		$this->view->sales = DailySales::sum(array(
			'column'		=> 'value',
			'conditions'	=> "rep = $user->id",
			'group'			=> 'date',
			'order'			=> 'date DESC',
			'limit'			=> '20',
		));

		$this->view->history = ContactRecord::find(array(
			'conditions'	=> 'user = ?1',
			'bind'			=> array(1 => $id),
			'order'			=> 'date DESC',
			'limit'			=> '30',
		));

		$this->view->topDay = DailySales::sum(array(
			'column'		=> 'value',
			'conditions'	=> "rep = $id",
			'group'			=> 'date',
			'order'			=> 'sumatory DESC',
			'limit'			=> '1',
		));

		$builder = new Builder();
		$this->view->topMonth = $builder
			->columns(array('topValue' => 'SUM(value)', 'month' => 'MONTH(date)', 'year' => 'YEAR(date)'))
			->from('App\Models\DailySales')
			->where("rep = $id")
			->groupBy(array('month', 'year'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$builder = new Builder();
		$this->view->topWeek = $builder
			->columns(array('topValue' => 'SUM(value)', 'week' => 'WEEK(date)', 'year' => 'YEAR(date)'))
			->from('App\Models\DailySales')
			->where("rep = $id")
			->groupBy(array('week', 'year'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

        $builder = new Builder();
		$this->view->topYear = $builder
			->columns(array('topValue' => 'SUM(value)', 'year' => 'YEAR(date)'))
			->addFrom('App\Models\DailySales', 's')
            ->join('App\Models\Calendar', 'c.calendarDate = s.date', 'c')
			->where("rep = $id")
			->groupBy(array('c.financialYear'))
			->orderBy('topValue DESC')
			->limit(1)
			->getQuery()
			->execute();

		$quotes = new Quotes();
		$this->view->quotes = $quotes->find(array(
			'columns'	=> ['count' => 'count(*)'],
			'conditions'	=> 'month(date) = month(now()) AND year(date) = year(now()) AND user = ?1',
			'bind'		=> [1 => $id ],
		));
		$this->view->wonQuotes = $quotes->find(array(
			'columns'	=> ['count' => 'count(*)'],
			'conditions'	=> 'month(date) = month(now()) AND year(date) = year(now()) AND sale = 1 AND user = ?1',
			'bind'		=> [1 => $id ],
		));

		$this->assets->collection('footer')
			->addJs('/js/customers/customers.js')
            ->addJs('https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.2/Chart.bundle.min.js');

        $this->assets->collection('header')
            ->addCss('//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css');

	}

}
