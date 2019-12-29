<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Manage</h6>
				<h4 class="header-title">Quotes</h4>
			</div>
			<div class="col text-right">
				{{ linkTo(['quote/new/', 'New Quote', 'class': 'btn btn-primary']) }}
			</div>
		</div>
	</div>
</div>

<div class="container">
	<div class="card shadow-sm">
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
			<table class="table">
				<thead>
					<th>#</th>
					<th>Date</th>
					<th>Custumer</th>
					<th>Reference</th>
					<th>Value</th>
					<th>Actions</th>
				</thead>
				<tbody>
					{% for quote in quotes %}
					<tr>
						<td>{{ linkTo(['quotes/view/' ~ quote.quoteId, quote.quoteId]) }}</td>
						<td>{{ quote.date }}</td>
						<td>{{ quote.customer.customerName }}</td>
						<td>{{ quote.reference }}</td>
						<td align="right">{{ quote.value|money }}</td>
						<td>
							<div class="btn-group" role="group" aria-label="Basic example">
								<button type="button" class="btn btn-secondary btn-sm">Won</button>
								<button type="button" class="btn btn-secondary btn-sm">Lost</button>
							</div>
						</td>
					</tr>
					{% endfor %}
				</tbody>
			</table>
		</div>
	</div>
</div>
