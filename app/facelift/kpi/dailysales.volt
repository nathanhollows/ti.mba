<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Record</h6>
				<h4 class="header-title">Daily Sales Log</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group" role="group" aria-label="Basic example">
					{{ linkTo(['kpi/dailysales/' ~ yesterday, 'Yesterday', 'class':'btn btn-primary']) }}
					{{ linkTo(['kpi/dailysales/', 'Today', 'class':'btn btn-primary']) }}
					{{ linkTo(['kpi/dailysales/' ~ tomorrow, 'Tomorrow', 'class':'btn btn-primary']) }}
				</div>
			</div>
		</div>
		<hr class="w-100">
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ content() }}
			{{ flashSession.output() }}
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col col-lg-8">
			<table class="table table-hover w-100 bg-white rounded border">
				<thead>
					<tr>
						<th></th>
						<th>Rep</th>
						<th>Q</th>
						<th>Ref</th>
						<th align="right">Value</th>
						<th></th>
					</tr>
				</thead>
				{% for sale in records %}
				<tr>
					<td>
						<img src="{{ url('img/icons/edit-2.svg') }}" class="feather"></img>
					</td>
					<td>{{ sale.agent.name }} &#9;</td>
					<td>
						<input type="checkbox" {% if sale.quoted %}checked{% endif %}></input>
					</td>
					<td>{{ sale.customerReference }}</td>
					<td align="right">{{ sale.value|money }}</td>
					<td>
						<img src="{{ url('img/icons/delete.svg') }}" class="feather"></img>
					</td>
				</tr>
				{% endfor %}
			</table>
		</div>
	<div class="col">
			<ul class="list-group mb-3">
				<li class="list-group-item">
					<strong>Summary</strong>
				</li>
				{% for item in salesByAgent %}
				<li class="list-group-item">
					{% for user in users %}
					{% if user.id == item.rep %}
					{{ user.name }}
					{% break %}
					{% endif %}
					{% endfor %}
					<span class="float-right"> ${{ item.sumatory|number }}</span>
				</li>
				{% endfor %}
				<li class="list-group-item">
					<strong>Total</strong>
					<span class="float-right"> <strong>${{ total|number }} </strong></span>
				</li>
				<li class="list-group-item">
					<strong>Week Total</strong>
					<span class="float-right"> <strong>${{ weekTotal|number }} </strong></span>
				</li>
			</ul>
			<ul class="list-group mb-3">
				<li class="list-group-item"><strong>Daily Budget</strong></li>
				<li class="list-group-item">
					<b>Target: </b><span class="float-right">${{ (budget.budget/budget.days)|number }}</span>
					<br />
					<br />
					<div class="progress">
						{% if (total/(budget.budget/budget.days))*100 >= 100 %}
						{% set progress = 100 %}
						{% set label = (total/(budget.budget/budget.days))*100 %}
						{% set status = '-success' %}
						{% else %}
						{% set status = '-warning' %}
						{% set progress = ((total/(budget.budget/budget.days))*100)|number %}
						{% set label = progress %}
						{% endif %}
						<div class="progress-bar progress-bar{{ status }} " role="progressbar" aria-valuenow="{{ progress }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ progress }}%;">{{ label|number }}%
							<span class="sr-only"></span>
						</div>
					</div>
				</li>
			</ul>
		</div></div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			<form action="/kpi/savesales" method="POST" role="form" id="foo">
				<table data-editable data-editable-spy class="table table-hover table-responsive">
					<thead>
						<tr>
							<th></th>
							<th>Rep</th>
							<th>Quoted</th>
							<th>Reference</th>
							<th>Value</th>
						</tr>
					</thead>

					<tbody>
						{# Loop through the days items #}
						{% set value = 0%}
						{% for item in records %}
						<tr class="record">
							<td>
								<a href="#" data-href="/kpi/deletesale/{{ item.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete"><img src="{{ url('img/icons/x-circle.svg') }}"</a>
							</td>
							<td>
								{{ hidden_field('id[]', 'value': item.id) }}
								{{ hidden_field('timestamp[]', 'value': item.timestamp) }}
								{{ select_static('rep[]', users, 'using': ['id', 'name'], 'value': item.rep, 'class': 'data') }}
							</td>
							<td>
								{{ check_field('quoted[]','value': '0', 'hidden': 'true', 'checked': 'true') }}
								{% if item.quoted == 0 %}
								{{ check_field('quoted[]','value': '1', 'class', 'data') }}
								{% else %}
								{{ check_field('quoted[]','value': '1', 'class', 'data', 'checked': 'true') }}
								{% endif %}
							</td>
							<td>
								{{ text_field('customerReference[]', 'value': item.customerReference ) }}
							</td>
							<td>
								{{ numeric_field('amount[]', 'value': item.value, 'step': 'any') }}
							</td>
							{% set value = value + item.value %}
						</tr>
						{% endfor %}
						<!-- The last <tr> in the <tbody> will be used as template for new rows -->
						<tr>
							<td></td>
							<td>
								{{ form.render('id[]') }}
								{{ form.render('date') }}
								{{ form.render('rep[]') }}
							</td>
							<td>{{ check_field('quoted[]','value': '0', 'checked': true, 'hidden': true) }}
								{{ form.render('quoted[]') }}</td>
							<td>{{ form.render('customerReference[]') }}</td>
							<td>
								{{ form.render('amount[]') }}
							</td>
						</tr>
						</tbody>
						<tfoot>
							<tr>
								<th></th>
								<th>Rep</th>
								<th>Quoted</th>
								<th>Reference</th>
								<th>Value</th>
							</tr>
						</tfoot>
				</table>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
		
	</div>
</div>

<style>
.rep {
	white-space: pre;
}
