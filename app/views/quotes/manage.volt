<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">My quotes</h4>
				<h6 class="header-pretitle">
					You have <strong>{{ quotes|length }}</strong> active quote{% if quotes|length != 1 %}s{% endif %} worth <strong>{{ value|money }}</strong></h6>
			</div>
			<div class="col text-right">
				{{ linkTo(['quotes/new/', 'New Quote', 'class': 'btn btn-primary']) }}
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			<table class="table bg-white rounded bordered mt-4 shadow">
				<thead>
					<th>#</th>
					<th>Date</th>
					<th>Customer</th>
					<th>Reference</th>
					<th class="text-right">Value</th>
					<th class="text-right">Actions</th>
				</thead>
				<tbody>
					{% for quote in quotes %}
					<tr>
						<td>
							<strong>{{ linkTo(['quotes/view/' ~ quote.quoteId, quote.quoteId]) }}</strong>
						</td>
						<td>{{ quote.date }}</td>
						<td>{{ linkTo(['customers/view/'~ quote.customer.customerCode, quote.customer.name]) }}</td>
						<td>{{ quote.reference }}</td>
						<td align="right">{{ quote.value|money }}</td>
						<td align="right">
							<div class="btn-group" role="group" aria-label="Basic example">
								<a href="{{ url('quotes/won/' ~ quote.quoteId ) }}" class="btn btn-outline-success btn-sm">Won</a>
								<a href="{{ url('quotes/lost/' ~ quote.quoteId ) }}" class="btn btn-outline-danger btn-sm">Lost</a>
							</div>
							<div class="btn-group " role="group" aria-label="Actions">
								<div class="btn-group" role="group">
									<button id="btnGroupDrop1" type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										Actions
									</button>
									<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
										{{ linkTo(['followup/?job=' ~ quote.quoteId, 'Add Note', 'class': 'dropdown-item open-modal']) }}
										{{ linkTo(['quotes/new?copy=' ~ quote.quoteId, 'Duplicate quote', 'class': 'dropdown-item']) }}
										{{ linkTo(['quotes/delete/' ~ quote.quoteId, 'Delete quote', 'class': 'dropdown-item text-danger delete confirm-delete']) }}
									</div>
								</div>
							</div>
						</td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
	</div>
</div>
