{{ content() }}

{% for customer in page.items %}
{% if loop.first %}
<table class="table table-hover">
	<thead>
		<tr>
			<th>Code</th>
			<th>Customer Type</th>
			<th>Name</th>
			<th>Edit</th>
			<th>Delete</th>
		</tr>
	</thead>
	<tbody>
		{% endif %}
		<tr>
			<td>{{ customer.customerId }}</td>
			<td>{{ customer.customerGroup }}</td>
			<td>{{ customer.customerName }}</td>
			<td width="7%">{{ link_to("customers/edit/" ~ customer.customerId, 'Edit', 'class': 'btn btn-default') }}</td>
			<td width="7%">{{ link_to("customers/delete/" ~ customer.customerId, 'Delete', 'class': 'btn btn-danger') }}</td>
		</tr>
		{% if loop.last %}
	</tbody>
</table>
{% endif %}
{% else %}
No customers found
{% endfor %}

<div class="pagination">
	<li>{{ link_to("customers/search", 'First') }}</li>
	<li>{{ link_to("customers/search?page=" ~ page.before, 'Previous') }}</li>
	<li>{{ link_to("customers/search?page=" ~ page.next, 'Next') }}</li>
	<li>{{ link_to("customers/search?page=" ~ page.last, 'Last') }}</li>
	<span class="help-inline">{{ page.current }} of {{ page.total_pages }}</span></li>
</div>