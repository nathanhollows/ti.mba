{{ order|length }}
<td>
	{{ order.orderNumber }}
	<span hidden>{{ order.rep }}</span>
</td>
{% if order.customerCode is null %}
<td></td>
{% else %}
<td>{% if order.customer %}{{ order.customer.name}}{% endif %}<br>
	{{ order.customerRef }}</td>
{% endif %}
<td>{{ date("M d", strtotime(order.date)) }} <br>
	{% if order.eta %}{{ date("M d", strtotime(order.eta)) }} {% endif %}</td>
<td>
	<p>
	{% if order.scheduled is 1 %}
	<span class="badge badge-success">Scheduled</span>
	{% elseif order.followUp is 1 %}
	<span class="badge badge-warning">Follow Up</span>
	{% endif %}
	</p>
	<p>{% if order.location %} <span class="badge badge-dark">{{ order.whereabouts.name }}</span> {% endif %}</p>
</td>
