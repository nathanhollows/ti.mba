{% set startDate = date %}
<div class="container">
	<div class="header py-3">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">Sales by Region</h4>
				<h6 class="header-pretitle">Apr {{ date("Y", strtotime(date)) }} - Mar {{ date("Y", strtotime(date ~ "
					+1 year")) }}</h6>
			</div>
			<div class="col text-right">
				<div class="btn-group" role="group" aria-label="Change report year">
					{{ linkTo(["reports/regions/" ~ (year - 1), year - 1, "class": "btn btn-info"]) }}
					{{ linkTo(["reports/regions/" ~ (year), year, "class": "btn btn-info active"]) }}
					{% if date("Y") >= (year + 1) %}
					{{ linkTo(["reports/regions/" ~ (year + 1), year + 1, "class": "btn btn-info"]) }}
					{% endif %}

				</div>
			</div>
		</div>
		<hr class="w-100">
	</div>


	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>

</div>

<div class="container">
	<div class="row">
		<div class="col">
			<table class="table table-hover bg-white shadow">
				<thead class="thead-dark">
					<tr>
						<th>Manager / Regions</th>
						{% for i in 4..15 %}
						<th class="text-right">{{ date("M", strtotime("1970-"~i%12~"-13")) }}</th>
						{% endfor %}
						<th class="text-right">Totals</th>
					</tr>
				</thead>
				<tbody>
					{% for user in users %}
					{% if user.regions|length is 0 %}
					{% continue %}
					{% endif %}
					<tr>
						<td colspan="14" class="bg-light"><strong>{{ user.name }}</strong></td>
					</tr>
					{% for region in user.regions %}
					<tr>
						<td class="pl-3">
							{{ linkTo("reports/region/" ~ region.nicename, region.name) }}
						</td>
						{% set figures = region.getSales(startDate) %}
						{% set date = startDate %}
						{% set index = 0 %}
						{% set total = 0 %}
						{% for i in 1..12 %}
						<td class="text-right">
							{% if index < figures|length %} {% if date("Y-m", strtotime(date))==figures[index].period %}
								${{ figures[index].value|number }} {% set total +=figures[index].value %} {% set index
								+=1 %} {% else %} - {% endif %} {% set date=date('Y-m', strtotime(date ~ " +1 months" ))
								%} {% else %} - {% endif %} </td>
								{% endfor %}
						<td class="text-right">
							<strong>${{ total|number }}</strong>
						</td>
					</tr>
					{% endfor %}
					{% endfor %}
				</tbody>
				<tfoot class="thead-dark">
					<tr>
						<th> </th>
						{% for i in 4..15 %}
						<th class="text-right">{{ date("M", strtotime("1970-"~i%12~"-13")) }}</th>
						{% endfor %}
						<th class="text-right">Totals</th>
					</tr>
				</tfoot>
			</table>
			<p>
				<strong>Notes:</strong><br>
				Updated daily. Sales are based on customer location only.<br>
				Regions and reps can be reassigned {{ linkTo(["settings/salesareas", "here"]) }}
			</p>
		</div>
	</div>
</div>