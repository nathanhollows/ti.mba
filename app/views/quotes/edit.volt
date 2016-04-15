{{ content() }}
{{ flashSession.output() }}
<div class="row">
	<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Details</h3>
			</div>
			<div class="panel-body">
				{{ quote.customer.customerName }} <br>
				{{ quote.customerContact.name }} <br>
				{{ quote.customerRef }} <br>
				{{ quote.webId }} <br>
				{{ quote.date }} <br>
				{{ quote.salesRep.name }} <br>
				{{ quote.genericStatus.name }} <br>
			</div>
		</div>

		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Notes</h3>
			</div>
			<div class="panel-body">
				{{ quote.details }}
			</div>
		</div>
	</div>

	<div class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Items
				<a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('quotes/item/' ~ quote.id) }}' data-target="#modal-ajax"><i class="fa fa-plus"></i> Add Item</a>
				</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Item</th>
								<th>Width</th>
								<th>Thickness</th>
								<th>Grade</th>
								<th>Treatment</th>
								<th>Dryness</th>
								<th>Finish</th>
								<th>Price</th>
								<th>Lineal</th>
							</tr>
						</thead>
						<tbody>
						{% for item in items %}
							<tr>
								<td>{{ item.id }}</td>
								<td>{{ item.width }}</td>
								<td>{{ item.thickness }}</td>
								<td>{{ item.grade }}</td>
								<td>{{ item.treatment }}</td>
								<td>{{ item.dryness }}</td>
								<td>{{ item.finish }}</td>
								<td>{{ item.price }}</td>
								<td>{{ item.linealTotal }}</td>
							</tr>
						{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>