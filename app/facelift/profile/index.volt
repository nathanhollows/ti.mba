<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Profile</h6>
				<h4 class="header-title">{{ user.name }}</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
	</div>
</div>

<div class="container">

	{{ content() }}
	{{ flashSession.output() }}

	<div class="row">
		<div class="col-3">
			<div class="row">
				<div class="card shadow mb-3 w-100">
					<div class="card-body">
						<h5 class="card-title">Contact Details</h5>
						<p class="card-text">
						{{ user.position }} <br>
						{{ user.directDial }} <br>
						{{ user.email }}
						</p>
					</div>
				</div>
			</div>

			{% if topDay|length > 0 %}
			<div class="row">
				<div class="card shadow mb-3 w-100">
					<div class="card-body">
						<h5 class="card-title">Sales Records</h5>
						<p class="card-text">
						Biggest Day		<span class="float-right" data-toggle="tooltip" data-placement="top" title="{{ date("dS M Y", strtotime(topDay.getFirst().date)) }}">${{ topDay.getFirst().sumatory|number }} </span>
						<span class="clearfix"></span>
						Biggest Week
						{% for item in topWeek %}
						{% set date1 = date("jS M", strtotime(item.year ~ "W" ~ item.week ~ "1")) %}
						{% set date2 = date("jS M Y", strtotime(item.year ~ "W" ~ item.week ~ "5")) %}
						<span class="float-right" data-toggle="tooltip" data-placement="top" title="{{ date1 ~ " - " ~ date2 }}">
							${{ item.topValue|number }}<br>
						</span>
						{% endfor %}
						<span class="clearfix"></span>
						Biggest Month {% for item in topMonth %}
						<span class="float-right" data-toggle="tooltip" data-placement="top" title="{{ date("M Y", strtotime(item.month ~ "/01/" ~ item.year)) }}"> ${{ item.topValue|number }}<br> </span>{% endfor %} 
						{% for item in topYear %}
						<span class="clearfix"></span>
						Biggest Year
						<span class="float-right" data-toggle="tooltip" data-placement="top" title="Year Starting April {{ item.year }}">
							${{ item.topValue|number }}<br>
						</span>
						{% endfor %}
						</p>
					</div>
				</div>
			</div>
			{% endif %}

			<div class="row">
				<div class="card shadow mb-3 w-100">
					<div class="card-body">
						<h5 class="card-title">Quotes</h5>
						<p class="card-text">
						Presented this month			
						<span class="float-right">{% for i in quotes%}
							{{ i.count }}
							{% endfor %}</span>
						<span class="clearfix"></span>
						Won this month				
						<span class="float-right">{% for i in wonQuotes%}
							{{ i.count }}
							{% endfor %}</span>
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="col-9">
			<div role="tabpanel">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li role="presentation" class="active">
						<a href="#home" aria-controls="home" role="tab" data-toggle="tab">Timeline</a>
					</li>
					<li role="presentation">
						<a href="#quotes" aria-controls="tab" role="tab" data-toggle="tab">Quotes</a>
					</li>
				</ul>

				<!-- Tab panes -->
				<div class="tab-content tab-timeline">
					<div role="tabpanel" class="tab-pane active fade in" id="home">
						{{ partial('timeline') }}
					</div>
					<div role="tabpanel" class="tab-pane fade" id="quotes">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Quotes</h3>
							</div>
							<div class="panel-body">
								<table class="table table-hover table-bordered">
									<thead>
										<tr>
											<th>
												Id
											</th>
											<th>
												Customer
											</th>
											<th>
												Reference
											</th>
											<th>
												Status
											</th>
										</tr>
									</thead>
									<tbody>
										{% for quote in user.quotes %}
										<tr>
											<td>
												{{ link_to("quotes/view/" ~ quote.quoteId, quote.quoteId) }}
											</td>
											<td>
												{{ quote.customer.customerName }}
											</td>
											<td>
												{{ quote.reference }}
											</td>
											<td>
												<span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span>
											</td>
										</tr>
										{% endfor %}
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip()
		var ctx = document.getElementById("myChart");
		var sales = [{% for item in sales %}"{{ date("D jS", strtotime(item.date)) }}",{% endfor %}];
		var myChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: sales.reverse(),
				datasets: [{
					label: '$',
					data: [{% for item in sales %}{{ item.sumatory }},{% endfor %}],
					borderWidth: 0
				}]
			},
			options: {
				tooltipFontSize: 10,
				percentageInnerCutout : 70,
				tooltips: {
					cornerRadius: 0,
				},
				scaleShowVerticalLines: false,
				scaleShowLabels: false,
				legend: {
					display: false,
				},
				scales: {
					xAxes: [{
						display: false
					}],
					yAxes: [{
						display: false
					}],
				}
			}
		});
	});
</script>
