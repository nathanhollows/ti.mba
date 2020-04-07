<div class="card shadow">
	<div class="card-header bg-white">
		<strong>Order {{ order.orderNumber }}</strong>
		<span class="float-right">
			<button type="button" data-order="{{ order.orderNumber }}" data-name="followUp" class="toggle-status btn btn-sm btn-{% if order.followUp is 1 %}warning{% else %}outline-secondary{% endif %}">Follow Up</button>
			<button type="button" data-order="{{ order.orderNumber }}" data-name="scheduled" class="toggle-status btn btn-sm btn-{% if order.complete is 0 and order.scheduled is 1 %}success{% else %}outline-secondary{% endif %}">Scheduled</button>
			<button type="button" data-order="{{ order.orderNumber }}" data-name="completed" class="toggle-status btn btn-sm btn-{% if order.complete is 1 %}danger{% else %}outline-secondary{% endif %}">Complete</button>
		</span>
	</div>
	{% if order.followUp %}
	<div class="alert alert-warning m-0 border-bottom rounded-0" role="alert">
		{{ order.followUpReason }}
	</div>
	{% endif %}
	<div class="card-body">
		<p>{% if order.customer %}
		<strong>{{ link_to('customers/view/' ~ order.customerCode|lower , order.customer.customerName) }}</strong>
		{% endif %}
		<br>
		<strong>Reference: </strong> 
		<span class="float-right">{{ order.customerRef }}</span>
		<br>
		<strong>Rep: </strong> 
		<span class="float-right">{{ order.rep }}</span>
		<br>
		<strong>Date: </strong> 
		<span class="float-right">{{ order.date }}</span>
		<br>
		<strong>ETA: </strong> 
		<span class="float-right">{{ order.eta }}</span>
		<br>
		<strong>Location: </strong> 
		<span class="float-right">{% if order.location %}{{ order.whereabouts.name }}{% endif %}</span>
		<br>
		<strong>Order Notes: </strong> {{ order.description }}
		<br>
		<strong>Despatcher Notes: </strong> {{ order.notes }}
		<br>
		</p>
	</div>
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
