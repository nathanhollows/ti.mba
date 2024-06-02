<div class="clearfix"></div>
{{ content() }}
{{ flashSession.output() }}
<div class="row row-flex row-flex-wrap">
	{% for key, rows in agentWeeklySales %}
		{% set sumTotal = 0 %}
		{% set totalNumber = 0 %}
		<div class="col-xs-12 col-sm-6 col-md-2 col-lg-2">
			<div class="panel panel-default flex-panel" style="position: relative; padding-bottom: 40px">
				<div class="panel-heading">
					<h3 class="panel-title">Week {{ loop.index }} sales</h3>
				</div>
				<div class="panel-body">
				<table class="table-condensed" width="100%">
					<thead>
						<tr>
							<th>Name</th>
							<th></th>
							<th style="text-align: right">Value</th>
						</tr>
					</thead>
					<tbody>
						{% for row in rows %}
							<tr>
								<td>
									{% for user in users %}
										{% if user.id == row['rep'] %}
											{{ user.name }}
											{% break %}
										{% endif %}
									{% endfor %}
								</td>
								<td>{{ row['count'] }}</td>
								<td align="right">${{ row['value']|number }}</td>
							{% set sumTotal = sumTotal + row['value'] %}
							{% set totalNumber = totalNumber + row['count'] %}
							</tr>
						{% endfor %}
					</tbody>
				</table>
				</div>
				<div class="panel-footer" style="position: absolute; width: 100%; bottom: 0">
					<strong>Week {{ loop.index }} Total ({{ totalNumber }}) <span class="pull-right">${{ sumTotal|number }}</span> </strong><br>
				</div>
			</div>
		</div>
	{% endfor %}
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Monthly Sales Summary</h3>
			</div>
			<div class="panel-body">
		<table class="table table-condensed table-hover">
			<thead>
				<tr>
					<th>Name</th>
					<th>Count</th>
					<th>Value</th>
				</tr>
			</thead>
			<tbody>
				{% for line in monthSales %}
					<tr>
					{% for user in users %}
						{% if user.id == line.rep %}
						<td>
						{{ link_to('profile/view/' ~ user.id ~ '/', user.name, 'class': 'text-primary') }}
						</td>
						{% break %}
						{% endif %}
					{% endfor %}
					<td>{{ line.count }}</td>
					<td>${{ line.sumatory|number }}</td>
					</tr>
				{% endfor %}
			</tbody>
            <tfoot>
                <tr>
                    <th>Total</th>
                    <th>{{ countMonth }}</th>
                    <th>${{ sumMonth|number }}</th>
                </tr>
                {% if budget is defined %}
                <tr>
                    <th>Budget</th>
                    <th></th>
                    <th>${{ budget.budget|number }}</th>
                </tr>
                {% endif %}
            </tfoot>
		</table>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Daily Sales</h3>
			</div>
			<div class="panel-body">
				<canvas id="myChart" width="5" height="2"></canvas>
			</div>
		</div>
	</div>
</div>

{% set base = (budget.budget / budget.days)|round %}
<script type="text/javascript">
	$(document).ready(function() {
		var myChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: [
				{% for item in sales %}
				"{{ date("D jS", strtotime(item.date)) }}",
				{% endfor %}
				],
				datasets: [{
					label: 'Budget',
					type: 'line',
					backgroundColor: "rgba(0,0,0,0)",
					borderWidth: 1,
					pointRadius: 0,
					borderColor: "rgba(0,0,0,0.5)",
					data: [
					{% for item in sales %}{{base}},{% endfor %}
					]
				},{
					label: 'Sales $',
					type: 'bar',
					borderColor: "rgb(54, 136, 206)",
					backgroundColor: "rgba(54, 136, 206,0.5)",
					data: [
					{% for item in sales %}
						{{ item.sumatory }},
					{% endfor %}
					]
				}]
			},
			options: {
			}
		});
	});
</script>

<script type="text/javascript">
	function showURL(event) {
	    var month = $("#month").find(":selected").attr("value");
	    var year = $("#year").find(":selected").attr("value");
	    var url = ("/reports/sales/" + year + "/" + month + "/");
	    window.location = url;
	}
$(function () {
    $("#datepicker")
    .datepicker({
        format: "yyyy/mm",
        startView: "months",
        minViewMode: "months",
        onSelect: function(dateText) {
            $(this).change();
        }
    })
    .change(function() {
        window.location.href = "/reports/sales/" + this.value;
    });
    $('#datebutton').click(function() {
        $('#datepicker').datepicker('show');
    });
});
</script>

<style media="screen">
.datepicker.datepicker-dropdown.dropdown-menu {
    background: white;
}
input#datepicker {
    height: 0px;
    width: 0px;
    padding: 0;
    border: none;
    visibility: hidden;
    display: inline;
    margin-top: 10px;
}
</style>
