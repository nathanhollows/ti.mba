<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Manage</h6>
				<h4 class="header-title">Quotes</h4>
			</div>
			<div class="col text-right">
				{{ linkTo(['quotes/new/', 'New Quote', 'class': 'btn btn-primary']) }}
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="card shadow">
		<div class="row">
			<div class="col">
				<div class="card-body">
					<h5 class="card-title">Active Quotes</h5>
					<p class="card-text">
					{{ quotes|length }} Quotes
					</p>
				</div>
			</div>
			<div class="col">
				<div class="card-body">
					<h5 class="card-title">Total Value</h5>
					<p class="card-text">
					{{ value|money }}
					</p>
				</div>
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
					<th>Custumer</th>
					<th>Reference</th>
					<th>Value</th>
					<th></th>
				</thead>
				<tbody>
					{% for quote in quotes %}
					<tr>
						<td>{{ linkTo(['quotes/view/' ~ quote.quoteId, "#" ~ quote.quoteId]) }}</td>
						<td>{{ quote.date }}</td>
						<td>{{ linkTo(['customers/view/'~ quote.customer.customerCode, quote.customer.name]) }}</td>
						<td>{{ quote.reference }}</td>
						<td align="right">{{ quote.value|money }}</td>
						<td>
							<div class="btn-group" role="group" aria-label="Basic example">
								<a href="{{ url('quotes/won/' ~ quote.quoteId ) }}" class="btn btn-outline-success btn-sm">Won</a>
								<a href="{{ url('quotes/lost/' ~ quote.quoteId ) }}" class="btn btn-outline-danger btn-sm">Lost</a>
							</div>
						</td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
	</div>
</div>
