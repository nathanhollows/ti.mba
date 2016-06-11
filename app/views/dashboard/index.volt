{{ content() }}
<div class="alert alert-warning">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<strong>Beta Testing!</strong> The timeline, dashboard, bug reporting (ironically) and followups / tasks are still being developed
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Budget and Sales {{ link_to('kpi', '<i class="fa fa-icon fa-pencil"></i>', 'class': 'pull-right') }}</h3>
			</div>
			<div class="panel-body">
				<canvas id="myChart" width="3" height="1"></canvas>
				<div class="row text-center">
				<hr>
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<strong>Total Sales</strong> <br>
						{% set sales = 0 %}
						{% for item in kpis %}
							{% set sales = sales + item.sales %}
						{% endfor %}
						${{ sales|number }}
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<strong>Charge Out</strong> <br>
						{% for item in kpis %}
							{% if loop.last %}
								${{ item.chargeOut|number }}
							{% endif %}
						{% endfor %}
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<strong>Total Sales</strong> <br>
						{% set orderCount = 0 %}
						{% for item in kpis %}
							{% set orderCount = orderCount + item.ordersSent %}
						{% endfor %}
						{{ orderCount|number }}
					</div>
				</div>
			</div>
		</div>		
	</div>
	<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
		<div class="list-group">
			<a href="/tasks" class="list-group-item active">
				<h4 class="list-group-item-heading">Follow Ups</h4>
				<p class="list-group-item-text"></p>
			</a>
			<ul class="list-group">
				{% for item in overdue %}
				<li class="list-group-item">
					<span class="badge">Overdue</span>
					{{ parser.parse(item.details) }}
				</li>
				{% endfor %}
				{% for item in today %}
				<li class="list-group-item">
					{{ parser.parse(item.details) }}
				</li>
				{% endfor %}
			</ul>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Holding</h3>
			</div>
			<div class="panel-body">
				Something can go here later
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

			</div>
		</div>	
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var myChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: [
				{% for item in kpis %}
				"Day {{ loop.index }}",
				{% endfor %}
				],
				datasets: [{
					label: 'Budget',
					backgroundColor: "rgba(0,0,0,0.2)",
					borderColor: "rgba(0,0,0,1)",
					data: [
					{% for item in kpis %}0,{% endfor %}
					]
				},{
					label: 'Sales $',
					borderColor: "rgb(52, 152, 219)",
					backgroundColor: "rgba(52, 152, 219, 0.2)",
					data: [
					{% set base = 37278 %}
					{% for item in kpis %}
						{% if loop.first %}
							{% set difference = 0 %}
						{% endif %}
						{% set difference = difference + item.sales - base %} 
							{{ difference }},
					{% endfor %}
					]
				},{
					label: 'Chargeout',
					backgroundColor: "rgba(55,188,155,0.2)",
					borderColor: "rgb(55,188,155)",
					data: [
					{% for item in kpis %}
						{{ item.chargeOut - (base * loop.index) }},
					{% endfor %}
					]
				}]
			},
			options: {
			}
		});
	});
</script>