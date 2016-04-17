{{ content() }}
{{ flashSession.output() }}

<div class="row">
	<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Details
				 <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('quotes/edit/' ~ quote.quoteId) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> Edit</a>
				 </h3>
			</div>
			<div class="panel-body">
				Quote {{ quote.id }} <span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.name }}</span> <br>
				{{ quote.customer.customerName }} <br>
				{{ quote.attention }} <br>
				{{ quote.reference }} <br>
				{{ link_to("quote/" ~ quote.webId, "Web Link") }} <br>
				{{ quote.date }} <br>
				{{ quote.rep.name }} <br>
			</div>
		</div>

		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Notes</h3>
			</div>
			<div class="panel-body">
				{{ quote.notes }}
				{{ quote.moreNotes }}
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
								<th>Specie</th>
								<th>Call Size</th>
								<th>Fin Size</th>
								<th>Description</th>
								<th>Lengths</th>
								<th>Qty</th>
								<th>Unit</th>
								<th>Price</th>
							</tr>
						</thead>
						<tbody>

						{% for item in items %}
							<tr>
								<td>{{ item.grade }}</td>
								<td>{{ item.callSize }}</td>
								<td>{{ item.finSize }}</td>
								<td>{{ item.finish }}</td>
								<td>{{ item.lengths }}</td>
								<td>{{ item.qty }}</td>
								<td>{{ item.unit.name }}</td>
								<td>{{ item.unitPrice }}</td>
							</tr>
						{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>