{{ content() }}

<form action="{{ static_url('orders/update') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
			<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
				<strong>Customer Ref</strong>
			</div>
			<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
				{{ order.customerRef }}
			</div>
			<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
				<strong>Order Placed</strong>
			</div>
			<div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">
				{{ order.date }}
			</div>
		</div>
		<div class="row">
				{{ form.render('orderNumber') }}
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<label for="eta">ETA</label>
				{{ form.render('eta') }}
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<label for="location">Location</label>
				{{ form.render('location') }}
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				{{ order.description }}
			</div>
		</div>

		<div class="row">
			{% for item in order.items %}
				<li class="list-group-item">
					{% if item.despatch %}
					<span class="label label-success pull-right">Scheduled</span>
					{% endif %}
					{{ item.itemNo }}.
					{{ item.width }} x {{ item.thickness }}
					{{ item.grade }}
					{{ item.treatment }}
					{{ item.dryness }}
					{{ item.finish }}<br>
					{{ item.sent }} / {{ item.ordered }} {{ item.unit }} supplied
				</li>
			{% endfor %}
		</ul>

		</div>

	</div>
