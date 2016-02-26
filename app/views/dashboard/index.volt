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
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Overdue follow ups</h3>
			</div>
			<div class="panel-body">
				<h4>{{ tasks|length }}</h4> 
				items on your Todo list.
			</div>
		</div>	
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Outstanding Quotes</h3>
			</div>
			<div class="panel-body">
				Count
			</div>
		</div>	
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">KPI</h3>
			</div>
			<div class="panel-body">
				Count
			</div>
		</div>	
	</div>
</div>