<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">{{ customer.customerCode }}</h6>
				<h4 class="header-title">{{ customer.name }}</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group" role="group" aria-label="Button group with nested dropdown">
					{{ linkTo(['followup/?company=' ~ customer.customerCode, 'Add Note', 'class': 'btn btn-primary open-modal']) }}
					<div class="btn-group" role="group">
						<button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1">
							{{ linkTo(['quotes/new/?company=' ~ customer.customerCode, 'Create New Quote', 'class': 'dropdown-item']) }}
							{{ linkTo(['customers/details/' ~ customer.customerCode, 'Print Contacts List', 'class': 'dropdown-item']) }}
							{{ linkTo(['customers/history/' ~ customer.customerCode, 'Print Contact Records', 'class': 'dropdown-item']) }}
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
			{{ content() }}
			{{ flash.output() }}
			{{ flashSession.output() }}
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col-sm-12 col-lg-3 mb-3">
			<div class="card shadow-sm mb-3">
				<div class="card-body">
					<h5 class="card-title">Details
						<a class="float-right open-modal text-sm text-muted" data-target="#modal-ajax" href='{{ url('customers/edit/' ~ customer.customerCode) }}' data-target="#modal-ajax">
							{{ emicon("pencil") }}
						</a>
					</h5>
				</div>
				<ul class="list-group list-group-flush mt-n4">
					<li class="list-group-item">
						<span class="title">Status</span> 
						{% if customer.state.style is defined %}
						<span class="badge badge-{{ customer.state.style }} float-right">{{ customer.state.name }}</span>
						{% else %}
						<span class="badge badge-secondary float-right">Not set</span>
						{% endif %}
					</li>
					<li class="list-group-item">
						<span class="title">Phone</span>
						<a href="tel:{{ customer.phone|stripspace }}" class="tel-link float-right">{{ customer.phone }}</a>
					</li>
					<li class="list-group-item">
						<span class="title">Fax</span> 
						<span class="float-right">{{ customer.fax }}</span>
					</li>
					<li class="list-group-item">
						<span class="title">Email</span> <a href="mailto:{{ customer.email }}" class="float-right email">{{ customer.email }}</a>
					</li>
					{% if customer.group is not empty %}
					<li class="list-group-item">
						<span class="title">Group</span>
						{{ customer.group.name }}
					</li>
					{% endif %}
					<li class="list-group-item"><span class="title">Sales Area</span>
						{% if customer.salesarea.name is defined %}
						<span class="float-right">{{ linkTo("customers/region/" ~ customer.salesarea.nicename, customer.salesarea.name ) }}</span>
						{% else %}
						<span class="badge badge-secondary float-right">Not set</span>
						{% endif %}
					</li>
					<li class="list-group-item"><span class="title">Rep</span>
						{% if customer.salesarea.rep.name is defined %}
						<span class="float-right">{{ customer.salesarea.rep.name }}</span>
						{% else %}
						<span class="badge badge-secondary float-right">Not set</span>
						{% endif %}
					</li>
				</ul>
			</div>
			{% if addresses %}
			<div class="card shadow-sm">
				<div class="card-body">
					<h5 class="card-title">Addresses</h5>
					{% for address in addresses %}
					<h6 class="card-subtitle mb-1 mt-2 text-muted">{{ address.type.typeDescription }}
						<a class="float-right text-muted open-modal" data-target="#modal-ajax" href='{{ url('
							address/edit/' ~ address.id) }}' data-target="#modal-ajax">
						{{ emicon("pencil") }}
						</a>
					</h6>
					<p class="card-text">
						{% if address.line1 is not empty %} {{ address.line1 }} <br>{% endif %}
						{% if address.line2 is not empty %} {{ address.line2 }} <br>{% endif %}
						{% if address.line3 is not empty %} {{ address.line3 }} <br>{% endif %}
						{% if address.city is not empty %} {{ address.city }} {% endif %} {% if address.zipCode is not
						empty %} {{ address.zipCode }}{% endif %}
						{% if address.country is not "New Zealand" %}<br> {{ address.country }} {% endif %}
						{% if address.type.typeDescription === "Delivery" %}
						<a href='{{ address.getGoogleMapsUrl() }}' target=" _blank">
							<small>
								View in maps {{ emicon("map") }}
							</small>
						</a>
						{% endif %}
					</p>
					{#<a href="https://maps.google.com/?q={{ address.line1 ~ " " ~ address.city }}"
						class="float-right text-info" target="_blank"><i class="fa fa-icon fa-map-marker"
							class="float-right"></i> </a>#}
					<a class="float-right text-info" data-target="#modal-ajax" href='{{ url(' address/edit/' ~
						address.id) }}' data-target="#modal-ajax"><i class="fa fa-edit"></i></a>
					{#<a href="https://maps.google.com/?q={{ address.line1 ~ " " ~ address.city }}"
						class="float-right text-info" target="_blank"><i class="fa fa-icon fa-map-marker"
							class="float-right"></i> </a>#}
					{% endfor %}
					<a href="{{ url('address/new/' ~ customer.customerCode) }}" class="card-link open-modal">Add
						Address</a>
				</div>
			</div>
			{% else %}
			<div class="card shadow-sm">
				<div class="card-body">
					<h5 class="card-title
								">Addresses</h5>
					<p class="card-text">No addresses set</p>
					<a href="{{ url('address/new/' ~ customer.customerCode) }}" class="card-link open-modal">Add
						Address</a>

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
					<a class="nav-link" id="pills-quotes-tab" data-toggle="pill" href="#pills-quotes" role="tab" aria-controls="pills-quotes" aria-selected="false">Quotes {% if customer.activeQuotes|length > 0 %}<span class="badge badge-primary text-light">{{ customer.activeQuotes|length}}</span>{% endif %}</a>
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
							<h5 class="card-title mb-n1 d-inline-block">Contacts</h5>
							<div class="btn-group float-right ml-3">
								<button id="unlock-contacts" class="btn btn-sm btn-secondary">
									{{ emicon("pencil") }}
									Edit List</button>
									<a class="btn btn-sm btn-primary open-modal" href="/contacts/new/{{ customer.customerCode }}" role="button">
										{{ emicon("plus") }} 
										Add
									</a>
								</div>
								<input id="contact-search" name="search" placeholder="Search..." type="text" data-list="#contacts-list" class="form-control w-25 float-right shadow-sm" autocomplete="off">
							</div>
							{% set role = "h" %}
							<ul class="list-group list-group-flush" id="contacts-list">
								{% for contact in contacts %}
								{% if contact.role is not role %}
								<li class="list-group-item bg-light font-weight-bold border-left-0 border-right-0 border-top-0 header">{% if contact.job %}{{ contact.job.name }}{% else %}Misc{% endif %}</li>
								{% set role = contact.role %}
								{% endif %}
								<li class="list-group-item">
									<div class="row">
										<div class="col-xs-12 col-md-4">
											<span class="xedit-toggle" data-name="name" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-placement="auto" data-title="Name">
												{{ contact.name }}
											</span>
											<span class="xedit-toggle xedit-hide float-right" data-name="role" data-type="select" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-placement="auto" data-title="Role" data-value="{{ contact.role }}" data-source='{{ roles }}'></span>
										</div>
										<div class="col-xs-12 col-md-3">
											<a href="tel:{{ contact.directDial|stripspace }}" class="xedit-toggle tel-link" data-name="directDial" data-type="tel" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-placement="auto" data-title="Direct Dial">{{ contact.directDial }}</a>
										</div>
										<div class="col-xs-12 col-md-5">
											<a href="mailto:{{ contact.email }}" class="xedit-toggle" data-name="email" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-placement="auto" data-title="Email">{{ contact.email }}</a>
											<a href="/contacts/delete/{{ contact.id }}" tabindex="-1" class="text-danger confirm-delete float-right">
												{{ emicon("trash-2") }}
											</a>
										</div>
									</div>
								</li>
								{% endfor %}
							</ul>
						</div>
					</div>
					<div class="tab-pane fade" id="pills-quotes" role="tabpanel" aria-labelledby="pills-quotes-tab">
						<table class="table table-hover rounded bg-white shadow-sm">
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
									<td> #{{ link_to('quotes/view/' ~ quote.quoteId ~ '/', quote.quoteId )}} </td>
									<td> {{ quote.reference }} </td>
									<td> ${{ quote.value|number }} </td>
									<td> {{ quote.rep.name }} </td>
									<td> <span class="badge badge-{{ quote.state.style }}">{{ quote.state.name }}</span></td>
								</tr>
								{% endfor %}
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="pills-orders" role="tabpanel" aria-labelledby="pills-orders-tab">
						{% for order in orders %}
						<div class="card shadow-sm mb-3">
							<div class="card-body">
								<h5 class="card-title">
									Order {{ linkTo("orders?customer="~order.customerCode~"&order="~order.orderNumber, order.orderNumber ) }}
									</h5>
								<h6 class="card-subtitle mb-2 text-muted">{{ order.customerRef }}
									<span class="float-right">
										{{ date('d M Y', strtotime(order.date)) }}
									</span>
								</h6>
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
										{% if item.complete %}
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
											Sent {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
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
											Sent {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
										</code>
										{% endif %}
										{% endif %}
										<span class="float-right">${{ item.price }}</span>
									</li>
									{% endfor %}
								</ul>
							</div>
						</div>
						{% endfor %}
						<div class="text-center">
							<strong>{{ linkTo(["orders?customer=" ~ customer.customerCode, "See historic orders", "class": "mt-3"]) }}</strong>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script src="/js/hideseek.min.js"></script>
	<script>
		$( document ).ready( function() {
			$('#contact-search').hideseek({
				throttle: 200,
				headers: '.header',
			});
			$.fn.editable.defaults.mode = 'popup';
			$('.xedit-toggle').editable('toggleDisabled');
			$('#unlock-contacts').click(function() {
				$('.xedit-toggle').editable('toggleDisabled');
			});
		});
	</script>
	<style>
		.email {
			white-space: nowrap; /* Keeps the email on one line */
			overflow: hidden; /* Ensures the overflow is not visible */
			text-overflow: ellipsis; /* Adds the ellipsis for overflowed text */
			max-width: 200px; /* Or whatever maximum width you prefer. Adjust based on your layout needs. */
			display: inline-block; /* Allows the element to have a width */
		}
		a.delete {
			visibility: hidden;
		}
		li:hover a.delete {
			visibility: visible;
		}
	</style>
	