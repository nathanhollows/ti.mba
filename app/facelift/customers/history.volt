<style type="text/css">
body {
  font-family: Helvetica, Arial, Sans-Serif;
  font-size: 10px;
}
table {
	font-size: 10px;
	border: 1px solid #828282;
}
th {
    text-align: left;
    background: #EAEAEA;
    padding: 0.3em 0.3em;
}
th, td {
	padding: 0.3em 0.3em;
}
table tr td, table tr th {
    page-break-inside: avoid;
}
</style>

From {{ content() }}

<h1>{{ customer.customerName }}</h1>
<h2>Contact Summary</h2>
<table class="table" width="100%">
	<thead>
		<tr>
			<th>Date</th>
			<th>Agent</th>
			<th>Type</th>
			<th>Reference</th>
			<th style="text-align: center;">Completed</th>
		</tr>
	</thead>
	<tbody>
		{% for record in history %}
			<tr>
				<td>{{ date("d-m-Y",strtotime(record.date)) }}</td>
				<td>{% if record.staff %}{{ record.staff.name }}{% endif %}</td>
				<td>{{ record.type.name }}</td>
				<td>{{ record.reference }}</td>
				<td align="center">{% if record.completed %}&#9745;{% else %}&#9744;{% endif %}</td>
			</tr>
		{% endfor %}
	</tbody>
</table>
{% if quotes|length > 0 %}
	<h2>Quote Summary</h2>
	<table class="table" width="100%">
		<thead>
			<tr>
				<th>ID</th>
				<th>Date</th>
				<th>Agent</th>
				<th>Reference</th>
				<th>Value</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			{% for quote in quotes %}
				<tr>
					<td>{{ quote.quoteId }}</td>
					<td>{{ date("d-m-Y",strtotime(quote.date)) }}</td>
					<td>{{ quote.rep.name }}</td>
					<td>{{ quote.reference }}</td>
					<td>${{ quote.value|number }}</td>
					<td>{{ quote.genericStatus.statusName }}</td>
				</tr>
			{% endfor %}
		</tbody>
	</table>
{% endif %}
<br>

<h2>Contact Details</h2>

	<table class="table" width="100%">
{% for record in history %}
		<thead>
			<tr>
				<th>Date</th>
				<th>Agent</th>
				<th>Type</th>
				<th>Reference</th>
				<th style="text-align: center;">Completed</th>
			</tr>
		</thead>
		<tbody>
				<tr>
					<td>{{ date("d-m-Y",strtotime(record.date)) }}</td>
					<td>{% if record.staff %}{{ record.staff.name }}{% endif %}</td>
					<td>{{ record.type.name }}</td>
					<td>{{ record.reference }}</td>
					<td align="center">{% if record.completed %}&#9745;{% else %}&#9744;{% endif %}</td>
				</tr>
				<tr>
					<td colspan="5" class="details page-break">{{ record.details|nl2br }}</td>
				</tr>
		</tbody>
{% endfor %}
	</table>

<script type="text/javascript">
	window.print();
</script>
