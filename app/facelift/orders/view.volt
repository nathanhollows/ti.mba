<div class="card shadow">
	<div class="card-header">
		<strong class="pt-2 pb-1 d-inline-block">Order {{ order.orderNumber }}</strong>
		<span class="float-right">
			<button type="button" data-order="{{ order.orderNumber }}" data-style="warning" data-name="followUp" class="toggle-status btn btn-sm btn-{% if order.followUp is 1 %}warning{% else %}outline-secondary{% endif %} mt-1">Follow Up</button>
			<button type="button" data-order="{{ order.orderNumber }}" data-style="success" data-name="scheduled" class="toggle-status btn btn-sm btn-{% if order.scheduled is 1 %}success{% else %}outline-secondary{% endif %} mt-1">Scheduled</button>
			<button type="button" data-order="{{ order.orderNumber }}" data-style="danger" data-name="completed" class="toggle-status btn btn-sm btn-{% if order.complete is 1 %}danger{% else %}outline-secondary{% endif %} mt-1">Complete</button>
		</span>
	</div>
	{% if not order.customer %}
	<div class="alert alert-info m-0 border-bottom rounded-0 text-center" role="alert">
		{{ linkTo(["customers/new", "Create new customer for " ~ order.customerCode ~ "?", "class": "alert-link"]) }}
	</div>
	{% endif %}
	{% if order.followUp %}
	<div class="alert alert-warning m-0 border-bottom rounded-0" role="alert">
		{{ order.followUpReason }}
	</div>
	{% endif %}
	<div class="card-body">
		<dl class="row">
			{% if order.customer %}
			<dt class="text-right col-4">Customer</dt>
			<dd class="col-8">
			<strong>{{ link_to('customers/view/' ~ order.customerCode|lower , order.customer.name) }}</strong>
			</dd>
			{% endif %}
			<dt class="text-right col-4">Reference</dt>
			<dd class="col-8">{{ order.customerRef }}</dd>
			<dt class="text-right col-4">Rep</dt>
			<dd class="col-8">
			{{ order.rep }}
			</dd>
			<dt class="text-right col-4">Date</dt>
			<dd class="col-8">{{ date("dS M", strtotime(order.date)) }}</dd>
			<dt class="text-right col-4">ETA</dt>
			<dd class="col-8"><a href="#" id="eta" data-type="date" data-pk="{{ order.orderNumber }}" data-url="/orders/update/" data-title="ETA" data-placement="bottom" class="xedit" accesskey="t">{{ order.eta }}</a>
			{% if order.eta %} - about {{ order.eta|timeAgoDate }}{% endif %}</dd>
			<dt class="text-right col-4">Location</dt>
			<dd class="col-8"><a href="#" id="location" data-type="select" data-source="[ {% for location in locations %}{value: {{ location.id }}, text: '{{ location.name }}'},{% endfor %} ]" data-pk="{{ order.orderNumber }}" data-value="{{ order.location }}" data-url="/orders/update/" data-title="Location" class="xedit" data-placement="bottom" data-autoclose="true" accesskey="l">{% if order.location %}{{ order.whereabouts.name }}{% endif %}</a></dd>
			<dt class="text-right col-4">Notes</dt>
			<dd class="col-8">{{ order.description }}</dd>
			<dt class="text-right col-4">Dispatcher Notes</dt>
			<dd class="col-8"><a href="#" id="notes" data-type="textarea" data-pk="{{ order.orderNumber }}" data-url="/orders/update/" data-title="Notes" data-mode="inline" class="xedit" style="white-space: pre-line;" accesskey="n">{{ order.notes }}</a></dd>
		</dl></div>
	<ul class="list-group list-group-flush border-top">
		{% for item in order.items %}
		<li class="list-group-item {% if item.complete is 1 %}complete{% endif %}">
			{% if item.grade === "FREIGHT" or item.grade === "CREDIT" or item.grade === "SETUP" %}
			<strong>{{ item.itemNo }}.</strong>
			{{ item.grade|lower|capitalize }}
			<span class="float-right">${{ item.price }}</span>
			{% continue %}
			{% endif %}
			{% if item.despatch %}
			<span class="badge badge-success float-right">Scheduled</span>
			{% endif %}
			{% if item.complete is 1 %}
			<span class="badge badge-info float-right">Complete</span>
			{% endif %}
			<strong>{{ item.itemNo }}.</strong>
			{{ item.width }} x {{ item.thickness }}
			{{ item.grade }}
			{{ item.treatment }}
			{{ item.dryness }}
			{{ item.finish }}
			<em>{{ item.notes }}</em><br>
			{% if item.complete is 1 %}
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			{% if item.tallies %}
			{% for tally in item.tallies %}
			{{ tally.pieces }}/{{ number_format(tally.length,1) }}
			{% endfor %}
			{% endif %}
			{% if item.sent > 0 %}
			<code>
				{{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
			</code>
			{% endif %}
			{% else %}
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			{% if item.tallies %}
			{% for tally in item.tallies %}
			{{ tally.pieces }}/{{ number_format(tally.length,1) }}
			{% endfor %}
			{% endif %}
			{% if item.sent > 0 %}
			<code>
				{{ item.sent }}/{{ item.ordered|right_trim }} {{ item.unit }}
			</code>
			{% endif %}
			{% endif %}
			<span class="float-right">${{ item.price }}</span>
		</li>
		{% endfor %}
	</ul>
	{% if order.dockets|length > 0 %}
	<div class="card-body">
		<p class="card-text">
		{% for docket in order.dockets %}
		{% if docket.carrier is defined %}
		{% if "Mainfreight" in docket.carrier %}
		<a href="https://www.mainfreight.com/Track/MSNZS/{{ docket.carrierLabel }}" target="_blank" title="Track and Trace">{{ docket.conNote }} <i class="fa fa-icon fa-external-link"></i></a>
		{% elseif "peter" in docket.carrier|lower %}
		<a href="http://www.pbt.co.nz/nick/results.cfm?ticketNo={{ docket.conNote }}" target="_blank" title="Track and Trace">{{ docket.conNote }} <i class="fa fa-icon fa-external-link"></i></a>
		{% else %} 
		{{ docket.conNote }} 
		{% endif %}
		{% else %}
		{{ docket.conNote }} 
		{% endif %}
		Sent {{ docket.date|timeAgoDate }} on {{ docket.carrier }}
		{% if docket.delivered is 0 %}
		{% if docket.status %}
		{% if docket.red > 2 %}
		<span class="badge badge-danger float-right" title="Status has not changed in {{ docket.red }} days">{{ docket.status }}</span>
		{% elseif "Received" in docket.status %}
		<span class="badge badge-dark float-right" title="Consignment loaded but not picked up">{{ docket.status }}</span>
		{% else %}
		<span class="badge badge-info float-right" title="Picked up an in transit">{{ docket.status }}</span>
		{% endif %}
		{% else %}
		<span class="badge badge-info float-right">Not Delivered</span>
		{% endif %}
		{% else %}
		<span class="float-right badge badge-success">Delivered</span>
		{% endif %}
		<br />
		{% endfor %}
		</p>
	</div>
	{% endif %}
</div>
