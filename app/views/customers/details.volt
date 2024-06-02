<META http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body {
  font-family: Helvetica, Arial, Sans-Serif;
  font-size: 10px;
}
table {
	font-size: 10px;
}
th {
	text-align: left;
}
</style>

{{ content() }}
<h1>ATS Timber Ltd</h1>
<h2>Customers Details</h2>
<hr>
<h2>{{ customer.name }}</h2>
<table width="100%">
	<tbody>
		{% for address in customer.addresses %}
			<tr>
				<th>{{ address.type.typeDescription }}</th>
				{% if address.line1 %}
					<td>{{ address.line1 }}</td>
				{% endif %}
				{% if address.line2 %}
					<td>{{ address.line2 }}</td>
				{% endif %}
				{% if address.line3 %}
					<td>{{ address.line3 }}</td>
				{% endif %}
				{% if address.city %}
					<td>{{ address.city }} {% if address.zipCode %}, {{ address.zipCode }}{% endif %}
				{% endif %}
			</tr>
		{% endfor %}
	</tbody>
</table>
<hr>
<table width="100%">
	<tbody>
		<tr>
			<th> Phone </th>
			<td> {{ customer.phone }} </td>
			<th> Email </th>
			<td> {{ customer.email }} </td>
		</tr>
		<tr>
			<th> Fax </th>
			<td> {{ customer.fax }} </td>
			<th> Status </th>
			<td> {{ customer.state.name }} </td>
		</tr>
		<tr>
			<th> Area </th>
			<td> {% if customer.salesarea.name is defined %} {{ customer.salesarea.name }} {% endif %}</td>
			<th> Account Manager </th>
			<td> {% if customer.salesarea.rep.name is defined %} {{ customer.salesarea.rep.name }} {% endif %} </td>
		</tr>
	</tbody>
</table>
<hr>
<table width="100%">
	<thead>
		<tr>
			<th>Contact Name </th>
			<th>Position </th>
			<th>Direct Dial </th>
			<th>Email </th>
		</tr>
	</thead>
	<tbody>
		{% for contact in customer.contacts %}
		<tr>
			<td> {{ contact.name }} </td>
			<td> 	
				{% if contact.position is not null and contact.position is not numeric %}
					{{ contact.position }}
				{% else %}
					{% if contact.job %} {{ contact.job.name }} {% endif %}
				{% endif %} 
			</td>
			<td> {{ contact.directDial }} </td>
			<td> {{ contact.email }} </td>
		</tr>
		{% endfor %}
	</tbody>
</table>
<script type="text/javascript">
	window.print();
</script>
