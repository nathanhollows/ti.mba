{{ content() }}

<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="alert alert-danger">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
			<strong>Alert!</strong> This is currently in active development and is not yet ready for production.
		</div>	
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Chargeout and Sales</h3>
			</div>
			<div class="panel-body">
				<div class="ct-chart ct-double-octave"></div>
			</div>
		</div>		
	</div>
	<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
		<div class="list-group">
			<a href="#" class="list-group-item active">
				<h4 class="list-group-item-heading">Currently in progress</h4>
				<p class="list-group-item-text">This week: Quotes</p>
			</a>
			<ul class="list-group">
				<li class="list-group-item">Creating and editing Quotes</li>
				<li class="list-group-item">KPIs</li>
				<li class="list-group-item">Sales tracking</li>
			</ul>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Overdue follow ups</h3>
			</div>
			<div class="panel-body">
				{{ tasks|length }} items on your Todo list.
			</div>
		</div>	
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Outstanding Quotes</h3>
			</div>
			<div class="panel-body">
				Count
			</div>
		</div>	
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Sales by Agent</h3>
			</div>
			<div class="panel-body">
				Count
			</div>
		</div>	
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-warning">
			<div class="panel-heading">
				<h3 class="panel-title">Quotes Presented (this month)</h3>
			</div>
			<div class="panel-body">
				{{ quotes.presented() }}
			</div>
		</div>	
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-warning">
			<div class="panel-heading">
				<h3 class="panel-title">Quotes Won (this month)</h3>
			</div>
			<div class="panel-body">
				{{ quotes.won() }}
			</div>
		</div>	
	</div>
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-warning">
			<div class="panel-heading">
				<h3 class="panel-title">Quote % Won (this month)</h3>
			</div>
			<div class="panel-body">
				{# Yeah, yeah, I shouldn't have logic in the view #}
				{{ quotes.won()/quotes.presented()*100 }}
			</div>
		</div>	
	</div>
</div>