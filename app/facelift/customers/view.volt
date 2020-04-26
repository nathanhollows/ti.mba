<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">{{ customer.customerCode }}</h6>
				<h4 class="header-title">{{ customer.customerName }}</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
					{{ linkTo(['followup/?company=' ~ customer.customerCode, 'Add Note', 'class': 'btn btn-primary open-modal']) }}
					<div class="btn-group" role="group">
						<button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1">
							{{ linkTo(['quotes/new/?company=' ~ customer.customerCode, 'New Quote', 'class': 'dropdown-item']) }}
							{{ linkTo(['customers/details/' ~ customer.customerCode, 'Print Contact List', 'class': 'dropdown-item']) }}
							{{ linkTo(['customers/history/' ~ customer.customerCode, 'Print Contact Summary', 'class': 'dropdown-item']) }}
						</div>
					</div>
				</div>
			</div>
			<hr class="w-100"/>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-sm-12 col-lg-3 mb-3">
			<div class="card shadow-sm mb-3">
				<div class="card-body">
					<h5 class="card-title">Customer Info
						<a class="float-right open-modal text-sm" data-target="#modal-ajax" href='{{ url('customers/edit/' ~ customer.customerCode) }}' data-target="#modal-ajax"><img src="/img/icons/edit-2.svg" class="feather"></a>
					</h5>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item"><span class="title">Status</span> <span class="badge badge-{{ customer.status.style }} float-right">{{ customer.status.name }}</span></li>
					<li class="list-group-item"><span class="title">Phone</span><a href="tel:{{ customer.phone|stripspace }}" class="tel-link float-right">{{ customer.phone }}</a></li>
					<li class="list-group-item"><span class="title">Fax</span> 
						<span class="float-right">{{ customer.fax }}</span>
					</li>
					<li class="list-group-item"><span class="title">Email</span> <a href="mailto:{{ customer.email }}" class="float-right">{{ customer.email }}</a></li>
					{% if customer.group is not empty %}
					<li class="list-group-item">
						<span class="title">Group</span>
						{{ customer.group.name }}
					</li>
					{% endif %}
					<li class="list-group-item"><span class="title">Sales Area</span>
						{% if customer.salesarea is not empty %}
						<span class="float-right">{{ customer.salesarea.name }}</span>
						{% endif %}
					</li>
					<li class="list-group-item"><span class="title">Rep</span>
						{% if customer.salesarea is not empty %}
						<span class="float-right">{{ customer.salesarea.rep.name }}</span>
						{% endif %}
					</li>
				</ul>
			</div>
			{% if addresses %}
			{# TODO: Show the header even if no addresses st yet #}
			<div class="card shadow-sm">
				<div class="card-body">
					<h5 class="card-title">Addresses</h5>
					{% for address in addresses %}
					<h6 class="card-subtitle mb-2 text-muted">{{ address.type.typeDescription }}</h6>
					<a class="float-right text-info open-modal" data-target="#modal-ajax" href='{{ url('address/edit/' ~ address.id) }}' data-target="#modal-ajax"><img src="/img/icons/edit-2.svg" class='feather'></a>
					<p class="card-text">
					{% if address.line1 is not empty %} {{ address.line1 }} <br>{% endif %}
					{% if address.line2 is not empty %} {{ address.line2 }} <br>{% endif %}
					{% if address.line3 is not empty %} {{ address.line3 }} <br>{% endif %}
					{% if address.city is not empty %} {{ address.city }} {% endif %} {% if address.zipCode is not empty %} {{ address.zipCode }}{% endif %}
					{% if address.country is not "New Zealand" %}<br> {{ address.country }} {% endif %}
					</p>
					{#<a href="https://maps.google.com/?q={{ address.line1 ~ " " ~ address.city }}" class="float-right text-info" target="_blank"><i class="fa fa-icon fa-map-marker" class="float-right"></i> </a>#}
					<a class="float-right text-info" data-target="#modal-ajax" href='{{ url('address/edit/' ~ address.id) }}' data-target="#modal-ajax"><i class="fa fa-edit"></i></a>
					{#<a href="https://maps.google.com/?q={{ address.line1 ~ " " ~ address.city }}" class="float-right text-info" target="_blank"><i class="fa fa-icon fa-map-marker" class="float-right"></i> </a>#}
					{% endfor %}
					<a href="{{ url('address/new/' ~ customer.customerCode) }}" class="card-link open-modal">Add Address</a>
				</div>
			</div>
			{% endif %}
		</div>
		<div class="col-sm-12 col-lg-9">
			<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" id="pills-timeline-tab" data-toggle="pill" href="#pills-timeline" role="tab" aria-controls="pills-timeline" aria-selected="true">Timeline</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="pills-contacts-tab" data-toggle="pill" href="#pills-contacts" role="tab" aria-controls="pills-contacts" aria-selected="false">Contacts</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="pills-quotes-tab" data-toggle="pill" href="#pills-quotes" role="tab" aria-controls="pills-quotes" aria-selected="false">Quotes</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="pills-orders-tab" data-toggle="pill" href="#pills-orders" role="tab" aria-controls="pills-orders" aria-selected="false">Orders <span class="badge badge-primary text-light">{{ customer.orders|length }}</span></a>
				</li>
			</ul>
			<div class="tab-content" id="pills-tabContent">
				<div class="tab-pane fade show active" id="pills-timeline" role="tabpanel" aria-labelledby="pills-timeline-tab">
					{{ partial('timeline') }}
				</div>
				<div class="tab-pane fade" id="pills-contacts" role="tabpanel" aria-labelledby="pills-contacts-tab">
					<div class="card shadow-sm">
						<div class="card-body">
							<h5 class="card-title mb-n1">Contacts</h5>
						</div>
						<ul class="list-group list-group-flush">
							{% set role = "h" %}
							{% for contact in contacts %}
							{% if contact.role is not role %}
						</ul>
						<h6 class="card-header font-weight-bold {% if loop.first %}border-top{% endif %}">{% if contact.job %}{{ contact.job.name }}{% else %}Misc{% endif %}</h6>
						<ul class="list-group list-group-flush">
							{% set role = contact.role %}
							{% endif %}
							<li class="list-group-item">
								<div class="row">
									<div class="col">
										<span class="xedit-toggle" data-name="name" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Name">
											{{ contact.name }}
										</span>
										<span class="xedit-toggle xedit-hide float-right" data-name="role" data-type="select" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Role" data-value="{{ contact.role }}" data-source='{{ roles }}'></span>
									</div>
									<div class="col">
										<a href="tel:{{ contact.directDial|stripspace }}" class="xedit-toggle tel-link" data-name="directDial" data-type="tel" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Direct Dial">{{ contact.directDial }}</a>
									</div>
									<div class="col">
										<a href="mailto:{{ contact.email }}" class="xedit-toggle" data-name="email" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Email">{{ contact.email }}</a>
										<a href="#" data-href="/contacts/delete/{{ contact.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete float-right"><i class="fa fa-times"></i></a>
									</div>
								</div>
							</li>
							{% endfor %}
						</ul>
					</div>
				</div>
				<div class="tab-pane fade" id="pills-quotes" role="tabpanel" aria-labelledby="pills-quotes-tab">
					<table class="table table-striped table-bordered bg-white shadow-sm">
						<thead>
							<tr>
								<th> ID </th>
								<th> Reference </th>
								<th> Value </th>
								<th> Rep </th>
								<th> Status </th>
							</tr>
						</thead>
						<tbody>
							{% for quote in customer.quotes %}
							<tr>
								<td> {{ link_to('quotes/view/' ~ quote.quoteId ~ '/', quote.quoteId )}} </td>
								<td> {{ quote.reference }} </td>
								<td> ${{ quote.value|number }} </td>
								<td> {{ quote.rep.name }} </td>
								<td> <span class="badge badge-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span></td>
							</tr>
							{% endfor %}
						</tbody>
					</table>
				</div>
				<div class="tab-pane fade" id="pills-orders" role="tabpanel" aria-labelledby="pills-orders-tab">
					{% for order in orders %}
					<div class="card shadow-sm mb-3">
						<div class="card-body">
							<h5 class="card-title">{{ order.customerRef }}</h5>
							<h6 class="card-subtitle mb-2 text-muted">{{ order.orderNumber }}</h6>
							<dl class="dl-horizontal">
								<dt>Date</dt>
								<dd>{{ date('d-m-Y', strtotime(order.date)) }}</dd>
								<dt>ETA</dt>
								<dd>{% if order.eta %}{{ date('d-m-Y', strtotime(order.eta)) }}{% endif %}</dd>
								<dt>Location</dt>
								<dd>{% if order.location %}{{ order.whereabouts.name }} {% endif %}</dd>
								<dt>Order Notes</dt>
								<dd>{{ order.description|escape }}</dd>
								<dt>Despatcher Notes</dt>
								<dd>{{ order.notes|escape }}</dd>
							</dl>
							<ul class="list-group list-group-flush">
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
									<code>
										{{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
									</code>
									{% else %}
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									{% if item.tallies %}
									{% for tally in item.tallies %}
									{{ tally.pieces }}/{{ number_format(tally.length,1) }}
									{% endfor %}
									{% endif %}
									<code>
										{{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
									</code>
									{% endif %}
									<span class="float-right">${{ item.price }}</span>
								</li>
								{% endfor %}
							</ul>
						</div>
					</div>
					{% endfor %}
				</div>
			</div>
		</div>
	</div>
</div>

