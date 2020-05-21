<div class="card shadow">
	<div class="card-header">
		<strong class="pt-2 d-inline-block">Outstanding Orders (<span id="count"></span>)</strong>
		<input onClick="this.select();" id="list-search" name="search" placeholder="Search.." type="text" data-list=".list" class="form-control shadow-sm w-25 float-right" accesskey="s" autocomplete="off" autofocus="true">
	</div>
	<div class="panel-body scroll">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Order</th>
					<th>Customer</th>
					<th>Date</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody class="list">
				{% for order in orders %}
				<tr class="order-listing" data-order="{{ order.orderNumber }}">
					<td>
						{{ order.orderNumber }}
						<span hidden>{{ order.rep }}</span>
					</td>
					{% if order.customerCode is null %}
					<td></td>
					{% else %}
					<td>{% if order.customer %}{{ order.customer.customerName}}{% else %}<em>{{ order.customerCode }}</em>{% endif %}<br>
						{{ order.customerRef }}</td>
					{% endif %}
					<td>{{ date("M d", strtotime(order.date)) }} <br>
						{% if order.eta %}{{ date("M d", strtotime(order.eta)) }} {% endif %}</td>
					<td class="badges">
						{% if order.scheduled is 1 %}
						<span class="badge badge-success">Scheduled</span>
						{% elseif order.followUp is 1 %}
						<span class="badge badge-warning">Follow Up</span>
						{% endif %}
						{% if order.location %} <span class="badge badge-dark">{{ order.whereabouts.name }}</span> {% endif %}
					</td>
				</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>
</div>
