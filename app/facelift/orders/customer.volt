<div class="card shadow">
	<div class="card-header">
		<strong class="pt-2 d-inline-block">{{ customer.customerName }} (<span id="count"></span>)</strong>
		<input id="list-search" name="search" placeholder="Search.." type="text" data-list=".list" class="form-control shadow-sm w-25 float-right" accesskey="s" autocomplete="off" autofocus="true">
	</div>
	<div class="scroll">
		<table class="table table-hover">
			<thead>
				<th>Order</th>
				<th>Reference</th>
				<th>Date In</th>
				<th>Status</th>
			</thead>
			<tbody class="list">
				{% for order in customer.orders75 %}
				<tr class="order-listing" data-order="{{ order.orderNumber }}">
					<td>{{ order.orderNumber }}</td>
					<td>{{ order.customerRef }}</td>
					{% if date("Y", strtotime(order.date)) == date("Y") %}
					<td>{{ date("d M", strtotime(order.date)) }}</td>
					{% else %}
					<td>{{ date("d M 'y", strtotime(order.date)) }}</td>
					{% endif %}
					<td>
						{% if order.complete %}
						<div class="badge badge-secondary">Complete</div>
						{% else %}
						<div class="badge badge-success">Active</div>
						{% endif %}
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>
</div>
