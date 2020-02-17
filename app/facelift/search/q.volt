<div class="container">
	<div class="row">
		<div class="col">
			<h3>Search</h3>
			<form class="" action="/search/" method="post">
				<div class="input-group">
					<input type="text" class="form-control" name="q" value="{{ query }}" autocomplete="off" autofocus="true" accesskey="s">
					<span class="input-group-append">
						<button class="btn btn-primary" type="submit">Go!</button>
					</span>
				</div>
			</form>
			{{ content() }}
			{{ flashSession.output() }}
			{% if not noResults %}

			{% set custl = customers|length %}
			{% set contl = contacts|length %}
			{% set ql = quotes|length %}
			{% if custl >= contl and custl >= ql %}{% set active = "pills-customers" %}
			{% elseif contl >= ql and contl >= custl %}{% set active = "pills-contacts" %}
			{% else %}{% set active = "pills-quotes" %}
			{% endif %}

			<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
				<li class="nav-item ml-n3">
					<strong class="nav-link">Filter Results</strong>
				</li>
				<li class="nav-item">
					<a class="nav-link active" id="pills-customers-tab" data-toggle="pill" href="#pills-customers" role="tab" aria-controls="pills-customers" aria-selected="true">Customers <span class="badge badge-primary">{{ customers|length }}</span></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="pills-contacts-tab" data-toggle="pill" href="#pills-contacts" role="tab" aria-controls="pills-contacts" aria-selected="false">Contacts <span class="badge badge-primary">{{ contacts|length }}</span></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="pills-quotes-tab" data-toggle="pill" href="#pills-quotes" role="tab" aria-controls="pills-quotes" aria-selected="false">Quotes <span class="badge badge-primary">{{ quotes|length }}<span></a>
				</li>
			</ul>
			<div class="tab-content" id="pills-tabContent">
				<div class="tab-pane fade show active" id="pills-customers" role="tabpanel" aria-labelledby="pills-customers-tab">
					<h4>Customers</h4>
					<ul class="list-group shadow-sm">
						{% for customer in customers %}
						<li class="list-group-item">{{ link_to('customers/view/' ~ customer.customerCode, customer.customerName) }}
							<span class="float-right"><a href="tel:{{ customer.phone|stripspace }}" class="tel-link">{{ customer.phone }}</a></span> 
						</li>
						{% endfor %}
					</ul>
				</div>
				<div class="tab-pane fade" id="pills-contacts" role="tabpanel" aria-labelledby="pills-contacts-tab">
					<h4>Contacts</h4>
					<div class="card card-sm shadow-sm">
						<table class="table">
							<thead>
								<tr>
									<th>Name</th>
									<th>Branch</th>
									<th class="hidden-xs">Phone</th>
									<th class="hidden-xs">Email</th>
								</tr>
							</thead>
							<tbody>
								{% for contact in contacts %}
								<tr>
									<td>
										{{ link_to('contacts/view/' ~ contact.id, contact.name) }}
									</td>
									<td>
										{{ link_to('customers/view/' ~ contact.company.customerCode, contact.company.customerName) }}
									</td>
									<td class="hidden-xs">
										<a href="tel:{{ contact.directDial|stripspace }}" class="tel-link">{{ contact.directDial|escape }}</a>
									</td>
									<td class="hidden-xs">
										<a href="mailto:{{ contact.email }}">{{ contact.email|escape }}</a>
									</td>
								</tr>
								{% endfor %}
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="pills-quotes" role="tabpanel" aria-labelledby="pills-quotes-tab">
					<h4>Quotes</h4>
					<ul class="list-group shadow-sm">
						{% for quote in quotes %}
						<li class="list-group-item">{{ link_to('quotes/view/'~ quote.quoteId, quote.quoteId) }} - {{ quote.reference|escape }} - {{ quote.customer.customerName|escape }}</li>
						{% endfor %}
					</ul>
				</div>
			</div>
			{% endif %}
		</div>
	</div>
	<div class="row">
		<div class="col">
			{% if not noTerm and noResults %}
			<h4>Nothing found for <code>{{ query|e }}</code></h4>
			{% endif %}
		</div>
	</div>
</div>
<style>
	body {
		overflow-y: scroll;
	}
</style>
<script>
	$( document ).ready(function() {
		$('#pills-tab a[href="#{{ active }}"]').tab('show') // Select tab by name
	});
</script>
