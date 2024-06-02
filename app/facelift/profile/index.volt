<div class="header bg-dark pb-5 pt-4 text-light mt-n3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Profile</h6>
				<h4 class="header-title text-white">{{ user.name }}</h4>
			</div>
		</div>
		<div class="header-footer mt-3">
			<canvas id="myChart" width="400" height="250"></canvas>
		</div>
	</div>
</div>

<div class="container mt-n3">
	<div class="row">
		<div class="col">
			<div class="card shadow mb-3">
				<div class="card-body">
					<h5 class="card-title">Contact</h5>
					<p class="card-text">
						{% if user.position %}{{ user.position }} <br>{% endif %}
						{% if user.directDial %}{{ user.directDial }} <br>{% endif %}
						{% if user.email %}{{ user.email }}{% endif %}
					</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card shadow mb-3">
				<div class="card-body">
					<h5 class="card-title">Sales Records</h5>
					<p class="card-text">
						{% if topDay|length > 0 %}
							<p class="card-text">
								Biggest Day <span class="float-right" data-toggle="tooltip" data-placement="top"
									title="{{ date(" dS M Y", strtotime(topDay.getFirst().date)) }}">${{
									topDay.getFirst().sumatory|number }} </span>
								<span class="clearfix"></span>
								Biggest Month {% for item in topMonth %}
								<span class="float-right" data-toggle="tooltip" data-placement="top" title="{{ date(" M
									Y", strtotime(item.month ~ "/01/" ~ item.year)) }}"> ${{ item.topValue|number }}<br>
								</span>{% endfor %}
								{% for item in topYear %}
								<span class="clearfix"></span>
								Biggest Year
								<span class="float-right" data-toggle="tooltip" data-placement="top"
									title="Year Starting April {{ item.year }}">
									${{ item.topValue|number }}<br>
								</span>
								{% endfor %}
					{% endif %}
					</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card shadow mb-3">
				<div class="card-body">
					<h5 class="card-title">Quotes this month</h5>
					<p class="card-text">
						{{ quotes[0].count }} Presented <br>
						{{ wonQuotes[0].count }} Won
					</p>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container">

	{{ content() }}
	{{ flashSession.output() }}

	<h4>Recent history</h4>
	{{ partial('timeline') }}
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"
	integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
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
		backgroundColor: "rgba(0,0,0,0)",
		borderColor: "#dc3545",
		pointRadius: 0,
		hoverRadius: 0,
		data: [
			{% for item in sales %}
                {{ item.sumatory }},
	{% endfor %}
	]}, 
        ]},
	options: {
		maintainAspectRatio: false,
			response: true,
				hover: {
			animationDuration: 0
		},
		scales: {
			xAxes: [{
				gridLines: {
					display: false,
					zeroLineBorderDash: [2, 2],
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
						borderDash: [2, 2],
						color: "rgba(255, 255, 255, 0.2)",
						zeroLineColor: "rgba(255, 255, 255, 0.2)",
						zeroLineBorderDash: [2, 2],
						drawBorder: false,
					},
					ticks: {
						// Include a dollar sign in the ticks
						callback: function (value, index, values) {
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
		if (el === sales && !sales.hasAttribute("data-active")) {
			sales.classList.remove("btn-secondary");
			sales.classList.add("btn-danger");
			sales.setAttribute("data-active", true);
			despatch.classList.remove("btn-primary");
			despatch.classList.add("btn-secondary");
			despatch.removeAttribute("data-active");
			myChart.data.datasets[0].hidden = false;
			myChart.data.datasets[1].hidden = true;
			myChart.update();
		} else if (el === despatch && !despatch.hasAttribute("data-active")) {
			sales.classList.add("btn-secondary");
			sales.classList.remove("btn-danger");
			sales.removeAttribute("data-active");
			despatch.classList.add("btn-primary");
			despatch.classList.remove("btn-secondary");
			despatch.setAttribute("data-active", true);
			myChart.data.datasets[1].hidden = false;
			myChart.data.datasets[0].hidden = true;
			myChart.update();
		}
	}
</script>