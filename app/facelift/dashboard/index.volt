{% if kpis.getLast().chargeOut is defined %}
	{% set chargeOut = kpis.getLast().chargeOut %}
{% else %}
	{% set chargeOut = 0 %}
{% endif %}

{% if budget.budget is defined and budget.budget is not 0 %}
	{% set dailybudget = budget.budget/budget.days %}
	{% set days = budget.days %}
	{% set monthbudget = budget.budget %}
{% else %}
	{% set days = 0 %}
	{% set dailybudget = 0 %}
	{% set monthbudget = 0 %}
{% endif %}

<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">Dashboard</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ content() }}
			{{ flash.output() }}
			{{ flashSession.output() }}
			{% if budget.budget is not defined or budget.budget is 0 %}
			<div class="alert alert-danger" role="alert">
				The budget for this month has not been set. This can be done in the {{link_to("reports/annual", "annual sales report", "class": "alert-link")}}
			</div>
			{% endif %}
		</div>
	</div>
</div>

<div class="container mb-3">
	<div class="row">
		<div class="col">
			<div class="card shadow-sm text-center">
				<div class="row">
					<div class="col">
							{% set salesDiff = (monthsSales - (dailybudget * sales|length)) %}
							<div class="card-body" data-toggle="tooltip" data-placement="top" title="${{ salesDiff|number }} {% if salesDiff > 0 %}ahead{% else %}behind{% endif %}">
							<span class="card-text">Month Sales</span>
							<h5 class="card-title mt-2 mb-3" >${{ monthsSales|number }}
							{% if salesDiff < 0 %}
							<img src="/img/icons/trending-down.svg" class="feather">
							{% else %}
							<img src="/img/icons/trending-up.svg" class="feather">
							{% endif %}
							</h5>
							<div class="progress" style="height: 6px;">
								{% if monthbudget > 0 %}
								{% set percentage = (monthsSales / monthbudget * 100)|round %}
								{% else %}
								{% set percentage = 0 %}
								{% endif %}
								<div class="progress-bar bg-danger" style="width: {{ percentage }}%;" role="progressbar" aria-valuenow="{{ percentage }}" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="col">
						{% set chargeDiff = (chargeOut - (dailybudget * sales|length)) %}
						<div class="card-body" data-toggle="tooltip" data-placement="top" title="${{ chargeDiff|abs|number }} {% if chargeDiff > 0 %}ahead{% else %}behind{% endif %}">
							<span class="card-text">Charge Out</span>
							{% if kpis is defined %}
							{% set chargeDiff = (chargeOut - (dailybudget * sales|length)) %}
							<h5 class="card-title mt-2 mb-3" >${{ chargeOut|number }} 
							{% if chargeDiff < 0 %}
							<img src="/img/icons/trending-down.svg" class="feather">
							{% else %}
							<img src="/img/icons/trending-up.svg" class="feather">
							{% endif %}
							</h5>
								{% if monthbudget > 0 %}
								{% set percentage = ( chargeOut / monthbudget * 100)|round %}
								{% else %}
								{% set percentage = 0 %}
								{% endif %}
							<div class="progress" style="height: 6px;">
								<div class="progress-bar bg-primary" style="width: {{ percentage }}%;" role="progressbar" aria-valuenow="{{ percentage }}" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							{% else %}
							<p class="card-text">$0</p>
							<div class="progress" style="height: 6px;">
								<div class="progress-bar bg-primary" style="width: 0%;" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							{% endif %}
						</div>
					</div>
					<div class="col">
						{% if dailybudget > 0 %}
						{% set percentage = ( daySales / dailybudget * 100)|round %}
						{% else %}
						{% set percentage = 0 %}
						{% endif %}
						<div class="card-body" data-toggle="tooltip" data-placement="top" title="{{ percentage }}% for today">
							<span class="card-text">Today's Sales</span>
							<h5 class="card-title mt-2 mb-3" >${{ daySales|number }}</h5>
							<div class="progress" style="height: 6px;">
								<div class="progress-bar bg-danger" style="width: {{ percentage }}%;" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card-body" data-toggle="tooltip" data-placement="top" title="{{ days }} days">
							<span class="card-text">Budget</span>
							<h5 class="card-title mt-1 mb-n1" >
								{# TODO: Make daily amount required #}
								${{ dailybudget|number }} / daily
								<br>
								${{ monthbudget|number }}  / month
							</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
				<div id="legend" aria-label="Toggle Graph">
					<a id="toggle-sales" onClick="toggleChart(this);"  data-set="0">Sales</a>
					<a id="toggle-despatch" onClick="toggleChart(this);" data-set="1">Despatch</a>
				</div>
			<div class="card bg-dark shadow mb-3 p-3">
				<canvas id="myChart" width="400" height="250"></canvas>
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-12 col-sm-6">
			<div class="card bg-white shadow-sm mb-4">
				<div class="card-body">
					<h5 class="card-title mb-0">Daily Sales</h5>
				</div>
				<ul class="list-group list-group-flush">
					{% for item in daySalesByAgent %}
					<li class="list-group-item list-group-item-action">
						{% for user in users %}
						{% if user.id == item.rep %}
							{{ link_to('profile/view/' ~ user.id ~ '/', user.name, 'class': 'text-primary') }}
						{% break %}
						{% endif %}
						{% endfor %}
						<span class="float-right"> ${{ item.sumatory|number }}</span>
					</li>
					{% endfor %}
					<li class="list-group-item">
						<strong>Total</strong>
						<span class="float-right"> <strong>${{ daySales|number }} </strong></span>
					</li>
					<li class="list-group-item">
						{% if dailybudget is not 0 %}
						{% if daySales > dailybudget %}
						{% set percent = 100 %}
						{% set label = ((daySales/dailybudget*100)|number) ~ '%' %}
						{% else %}
						{% set percent = (daySales/dailybudget*100)|number %}
						{% set label = percent ~ '%' %}
						{% endif %}
						{% else %}
						{% set percent = 0 %}
						{% set label = "" %}
						{% endif %}
						<div class="progress">
							<div class="progress-bar bg-danger" role="progressbar" aria-valuenow="{{ percent }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ percent }}%;">
								{{ label }}
								<span class="sr-only"></span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>

		<div class="col-12 col-sm-6">
			<div class="card bg-white shadow-sm mb-4">
				<div class="card-body">
					<h5 class="card-title mb-0">Monthly Sales</h5>
				</div>
				<ul class="list-group list-group-flush">
					{% for item in agentSales %}
					<li class="list-group-item list-group-item-action">
						<span>
							{% for user in users %}
							{% if user.id == item.rep %}
							{{ link_to('profile/view/' ~ user.id ~ '/', user.name, 'class': 'text-primary') }}
							{% break %}
							{% endif %}
							{% endfor %}
						</span>
						<span class="float-right"> ${{ item.sumatory|number }}</span>
					</li>
					{% endfor %}
					<li class="list-group-item">
						<strong>Total</strong>
						<span class="float-right"> <strong> ${{ monthsSales|number }} </strong></span>
					</li>
					<li class="list-group-item">
						<div class="progress">
							{% if monthbudget is not 0 %}
							{% set percent = (monthsSales / monthbudget * 100)|round %}
							{% else %}
							{% set percent = 0 %}
							{% endif %}
							<div class="progress-bar bg-danger" role="progressbar" aria-valuenow="{{ percent }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ percent }}%;">
								{{ percent }}%
								<span class="sr-only"></span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<script type="text/javascript">
	var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
	type: 'bar',
	data: {
		labels: [
			{% for item in sales %}
			"{{ date("jS", strtotime(item.date)) }}",
			{% endfor %}
		],
		datasets: [{
			label: 'Sales $',
			backgroundColor: "#dc3545",
			borderColor: "#dc3545",
			pointRadius: 0,
			hoverRadius: 0,
			data: [
				{% for item in sales %}
				{{ item.sumatory }},
				{% endfor %}
			]}, 
			{
				label: 'Despatch $',
				hidden: false,
				backgroundColor: "#007bff",
				borderColor: "#007bff",
				pointRadius: 0,
				hoverRadius: 0,
				data: [
					{% set acc = 0 %}
					{% for item in kpis %}
					{% if not loop.first and strtotime(item.date) - date is 172800%}0,{% endif %}
					{% set date = strtotime(item.date) %}
					{% if item.chargeOut - acc > 0 %}
					{{ item.chargeOut - acc}},
					{% endif %}
					{% if item.chargeOut > 0 %}
					{% set acc = item.chargeOut %}
					{% endif %}
					{% endfor %}
				]},
		]},
	options: {
		cornerRadius: 20,
		maintainAspectRatio: false,
		response: true,
		hover: {
			animationDuration:0
		},
		scales: {
			xAxes: [{
				maxBarThickness: 10,
				gridLines: {
					display: false,
					zeroLineBorderDash: [2,2],
					zeroLineWidth: 0,
					drawBorder: false,
					padding: 5,
				},
				ticks: {
					fontColor: "rgba(255, 255, 255, 0.6)",
				}
			}],
			yAxes: [{
				gridLines: {
					borderDash: [2,2],
					color: "rgba(255, 255, 255, 0.2)",
					zeroLineColor: "rgba(255, 255, 255, 0.2)",
					zeroLineBorderDash: [2,2],
					drawBorder: false,
				},
				ticks: {
					// Include a dollar sign in the ticks
					callback: function(value, index, values) {
						return '$' + Math.round(value / 1000) + 'k ';
					},
					fontColor: "rgba(255, 255, 255, 0.6)",
					beginAtZero: true,
				}
			}],
		},
		legend: {
			display: false,
		},
		tooltips: {
			backgroundColor: "#fff",
			titleFontColor: "#000",
			bodyFontColor: "#000",
			intersect: false,
			displayColors: false,
		}
	}
});

function toggleChart(el) {
	let sales = document.getElementById("toggle-sales");
	let despatch = document.getElementById("toggle-despatch");
	let set = el.attributes["data-set"].value;
	if (el.classList.contains("toggled-off")) {
		el.classList.remove("toggled-off");
	} else {
		el.classList.add("toggled-off");
	}
	myChart.data.datasets[set].hidden = !myChart.data.datasets[set].hidden;
	myChart.update();
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
</script>
<script type="text/javascript" charset="utf-8" src="/js/chart-round.js"></script>
<style>
#legend {
	cursor: pointer;
	position: absolute;
	top: 1em;
	right: 2em;
	z-index: 1;
	display: inline-flex;
	flex-direction: column;
	background: #152b3e69;
}
.toggled-off {
	opacity: 0.5;
}
#toggle-sales, #toggle-despatch {
	font-weight: bold;
	color: #f2f1eb;
    transition: all 0.4s ease;
}
#toggle-sales::before, #toggle-despatch::before {
    content: " ";
    width: 0.6em;
    height: 0.6em;
    display: inline-block;
    border-radius: 100%;
    margin: 0.1em 0.3em;
}
#toggle-sales::before {
    background: red;
}
#toggle-despatch::before {
    background: #007bff;
}
</style>
