{{ content() }}

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>Date</th>
				<th>Customer</th>
				<th>Sales Rep</th>
				<th>Reference</th>
				<th>Contact</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			{% for quote in quotes %}
			<tr>
				<td>
				{{ link_to("quotes/edit/" ~ quote.id, quote.id) }}</td>
				<td>{{ quote.date }}</td>
				<td>{{ quote.customerCode }}</td>
				<td>{{ quote.user }}</td>
				<td>{{ quote.customerRef }}</td>
				<td>{{ quote.contact }}</td>
				<td>{{ quote.status }}</td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
</div>