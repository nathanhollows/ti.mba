{{ content() }}

<form action="{{ static_url('orders/update') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
				{{ form.render('orderNumber') }}
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				{{ form.render('eta') }}
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				{{ form.render('location') }}
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