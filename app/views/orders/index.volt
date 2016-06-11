{{ flashSession.output() }}
{{ content() }}

<div class="row">
	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title"><b>Outstanding</b> Orders</h3>
					</div>
					<div class="panel-body">
						{{ orders|length }}
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title"><b>Scheduled</b> Today</h3>
					</div>
					<div class="panel-body">
						{{ scheduled|length }}
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Scheduled for Despatch</h3>
					</div>
					<div class="panel-body">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>Order Number</th>
									<th>Customer Ref</th>
									<th>Customer</th>
								</tr>
							</thead>
							<tbody>
								{% for order in scheduled %}
								<tr>
									<td>
				                        <a data-target="#modal-ajax" href='{{ url('orders/edit/' ~ order.orderNumber) }}' data-target="#modal-ajax">{{ order.orderNumber }}</a>
									</td>
									<td>{{ order.customerRef }}</td>
									<td>{{ order.customer.customerName }}</td>
								</tr>
								{% endfor %}
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-success">
			<div class="panel-heading">
				<h3 class="panel-title">Search</h3>
			</div>
			<div class="panel-body">
				<input id="search" name="search" data-toggle="hideseek" placeholder="Start typing here" type="text" data-list=".list" class="form-control">
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Outstanding Orders</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Order Number</th>
							<th>Customer</th>
							<th>Date</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody class="list">
						{% for order in orders %}
						<tr>
							<td>
		                        <a data-target="#modal-ajax" href='{{ url('orders/edit/' ~ order.orderNumber) }}' data-target="#modal-ajax">{{ order.orderNumber }}</a>
							</td>
							{% if order.customerCode is null %}
							<td></td>
							{% else %}
							<td>{{ order.customer.customerName}}<br>
							{{ order.customerRef }}</td>
							{% endif %}
							<td>{{ order.date }} <br> 
								{{ order.eta }} </td>
							<td>{% if order.scheduled is 1 %} <span class="label label-success">Scheduled</span> {% endif %}</td>
						</tr>
						{% endfor %}
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</div>