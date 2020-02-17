{% if kpis.getLast().chargeOut is defined %}
{% set chargeOut = kpis.getLast().chargeOut %}
{% else %}
{% set chargeOut = 0 %}
{% endif %}
{% set dailybudget = budget.budget/budget.days %}
<div class="header bg-dark pb-5 pt-4 text-light mt-n3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Overview</h6>
				<h4 class="header-title text-white">Dashboard</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group" role="group" aria-label="Toggle Graph">
					<button id="toggle-sales" type="button" onClick="toggleChart(this);" class="btn btn-sm btn-danger" data-class="btn-danger" data-set="0">Sales</button>
					<button id="toggle-despatch" type="button" onClick="toggleChart(this);" class="btn btn-sm btn-primary" data-class="btn-primary" data-set="1">Despatch</button>
				</div>
			</div>
		</div>
		<div class="header-footer mt-3">
			<canvas id="myChart" width="400" height="250"></canvas>
		</div>
	</div>
</div>

{{ content() }}

<div class="container mt-n3 mb-4">
	<div class="row">
		<div class="col">
			<div class="card shadow-sm text-center">
				<div class="row">
					<div class="col">
						<div class="card-body">
							<h5 class="card-title">Month Sales</h5>
							<p class="card-text">${{ monthsSales|number }}</p>
							<div class="progress" style="height: 6px;">
								{% set percentage = (monthsSales / budget.budget * 100)|round %}
								<div class="progress-bar bg-danger" style="width: {{ percentage }}%;" role="progressbar" aria-valuenow="{{ percentage }}" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card-body">
							<h5 class="card-title">Charge Out</h5>
							{% if kpis is defined %}
							<p class="card-text"> ${{ chargeOut|number }} </p>
							{% set percentage = ( chargeOut / budget.budget * 100)|round %}
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
						<div class="card-body">
							<h5 class="card-title">Daily Sales</h5>
							<p class="card-text">${{ daySales|number }}</p>
							{% set percentage = ( daySales / dailybudget * 100)|round %}
							<div class="progress" style="height: 6px;">
								<div class="progress-bar bg-danger" style="width: {{ percentage }}%;" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card-body">
							<h5 class="card-title">Budget</h5>
							<p class="card-text">
							${{ dailybudget|number }} / day
							<br>
							${{ budget.budget|number }}  / month
							</p>
						</div>
					</div>
				</div>
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
						{% if daySales > dailybudget %}
						{% set percent = 100 %}
						{% set label = ((daySales/dailybudget*100)|number) ~ '%' %}
						{% else %}
						{% set percent = (daySales/dailybudget*100)|number %}
						{% set label = percent ~ '%' %}
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
							{% set percent = (monthsSales / budget.budget * 100)|round %}
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
	type: 'line',
	data: {
		labels: [
			{% for item in sales %}
			"{{ date("jS", strtotime(item.date)) }}",
			{% endfor %}
		],
		datasets: [{
			label: 'Sales $',
			backgroundColor: "rgba(220, 53, 69, 0.0)",
			borderColor: "#dc3545",
			pointRadius: 0,
			hoverRadius: 0,
			data: [
				{% set base = (budget.budget / budget.days)|round %}
				{% for item in sales %}
				{{ item.sumatory }},
				{% endfor %}
			]}, 
			{
				label: 'Despatch $',
				hidden: false,
				backgroundColor: "rgba(0, 123, 255, 0.0)",
				borderColor: "#007bff",
				pointRadius: 0,
				hoverRadius: 0,
				data: [
					{% set acc = 0 %}
					{% for item in kpis %}
					{% if not loop.first and strtotime(item.date) - date is 172800%}0,{% endif %}
					{% set date = strtotime(item.date) %}
					{% if item.chargeOut - acc <= 0 %}
					0,
					{% else %}
					{{ item.chargeOut - acc}},
					{% endif %}
					{% if item.chargeOut > 0 %}
					{% set acc = item.chargeOut %}
					{% else %}
					{% set acc = 0 %}
					{% endif %}
					{% endfor %}
				]},
		]},
	options: {
		maintainAspectRatio: false,
		response: true,
		hover: {
			animationDuration:0
		},
		scales: {
			xAxes: [{
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
	if (el.classList.contains("btn-secondary")) {
		el.classList.remove("btn-secondary");
		el.classList.add(el.attributes["data-class"].value);
	} else {
		el.classList.add("btn-secondary");
		el.classList.remove(el.attributes["data-class"].value);
	}
	myChart.data.datasets[set].hidden = !myChart.data.datasets[set].hidden;
	myChart.update();
}
</script>
