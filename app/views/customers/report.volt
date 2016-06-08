{{ content() }}

<h1> Customer Summary for {{ customer.customerName }}</h1>
<hr>
<h2>Contact Details</h2>
	<ul>
		<li> {{ customer.customerCode }} </li>
		<li> {{ customer.customerName }} </li>
		<li> {{ customer.status.name }} </li>
		<li> {{ customer.customerPhone }} </li>
		<li> {{ customer.customerFax }} </li>
		<li> {{ customer.customerEmail }} </li>
		<li> {{ customer.group.name }} </li>
		<li> {{ customer.freightcarrier.name }} </li>
	</ul>
<hr>
<h2>Address</h2>
{% for address in customer.addresses %}
	{% if address.type.typeCode is 1 %}
		<h3>Billing Address </h3>
	{% else %}
		<h3>Physical Address </h3>
	{% endif %}
	{% if address.line1 %}
		{{ address.line1 }} <br>
	{% endif %}
	{% if address.line2 %}
		{{ address.line2 }},  <br>
	{% endif %}
	{% if address.line3 %}
	{% endif %}
	{% if address.city or address.zipCode or address.country %}
		{% if address.city %}
			{{ address.city }},  <br>
		{% endif %}
		{% if address.zipCode %}
			{{ address.zipCode }},  <br>
		{% endif %}
		{% if address.country %}
			{{ address.country }}  <br>
		{% endif %}
	{% endif %}
	<hr>
{% endfor %}
<h2>Contacts</h2>
<hr>
{% for contact in customer.contacts %}
	<strong>{{ contact.name }}</strong> <br>
	{% if contact.position is not null and contact.position is not numeric %}
		{{ contact.position }} <br>
	{% else %}
		{{ contact.job.name }} <br>
	{% endif %}
	{{ contact.email }} <br>
	{{ contact.directDial }} <br>
	<br>
{% endfor %}