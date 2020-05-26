<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">{{ date("D dS M Y", strtotime(current)) }}</h6>
				<h4 class="header-title">Daily Sales Log</h4>
			</div>
			<div class="col text-right">
				<nav aria-label="Page navigation example">
					<ul class="pagination float-right">
						<li class="page-item">
							<a class="page-link" href="{{url('kpi/dailysales/' ~ prev)}}" aria-label="Next">
								<span aria-hidden="true">&laquo;</span>
								<span class="sr-only">Next</span>
							</a>
						</li>
						<li class="page-item"><a class="page-link" href="{{ url("kpi/dailysales/") }}">Today</a></li>
						<li class="page-item">
							<a class="page-link" href="{{ url('kpi/dailysales/' ~ next) }}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
								<span class="sr-only">Next</span>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<hr class="w-100">
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
		<div class="col-sm-12 col-md-9">
			<form action="/kpi/savesales" method="POST" role="form" id="foo">
				<editable-table>
					<table data-editable data-editable-spy class="table m-0 table-hover shadow bg-white">
						<thead class="thead-dark">
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
									<a href="/kpi/deletesale/{{ item.id }}" class="text-danger delete confirm-delete">{{ icon("trash-2") }}</a>
								</td>
								<td>
									{{ hidden_field('id[]', 'value': item.id) }}
									{{ hidden_field('timestamp[]', 'value': item.timestamp) }}
									{{ select_static(['rep[]', users, 'using': ['id', 'name'], 'value': item.rep, 'class': 'data']) }}
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
							<tfoot class="thead-dark">
								<tr>
									<th></th>
									<th>Rep</th>
									<th>Quoted</th>
									<th>Reference</th>
									<th>Value</th>
								</tr>
							</tfoot>
					</table>
				</editable-table>
				<button type="save" class="btn btn-primary mt-3 shadow-sm">Submit</button>
			</form>
		</div>
		<div class="col-sm-12 col-md-3">
			<ul class="list-group mb-3">
				<li class="list-group-item bg-dark text-white">
					Summary
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
			<ul class="list-group">
				<li class="list-group-item bg-dark text-white">Daily Budget</li>
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
						<div class="progress-bar bg-danger" role="progressbar" aria-valuenow="{{ progress }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ progress }}%;">{{ label|number }}%
							<span class="sr-only"></span>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>

<style type="text/css">
editable-table input, editable-table select {
	border: none;
	background: transparent;
	width: 100%;
}
.table .thead-dark th {
	color: #fff;
	background-color: #2a3e4f;
	border-color: #2a3e4f;
}
.record:hover a.delete, .active a.delete {
	visibility: visible;
}

a.delete {
	visibility: hidden;
}
</style>
<script type="module" src="https://cdn.pika.dev/editable-table"></script>
<script>
	customElements.whenDefined("editable-table").then(() => {
		editableTable = document.querySelector("editable-table");
		// get records out of table
		records = editableTable.get();

		editableTable.addEventListener("record:update", function(event) {
			const { changeType, index, record } = event.detail;
			console.log(`record %d %s: %o`, index + 1, changeType, record);

		});
	});
</script>
