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
				<h3 class="panel-title">Items <button id="enable" class="btn btn-sm btn-default">Edit</button></h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Description</th>
								<th>Size</th>
								<th>Finish</th>
								<th>Notes</th>
								<th>Qty</th>
								<th>Unit</th>
								<th>Price</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="items">

							{% for item in items %}
							<tr>
								<td><a href="#" class="xedit" id="grade" data-type="text" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Grade">{{ item.legacy.description }}</a></td>
								<td>
									{# Because of legacy information I've had to account for the fact that#}

											<a href="#" class="xedit" id="width" data-type="number" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Width">{{ item.width }}</a> x 
											<a href="#" class="xedit" id="thickness" data-type="number" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Thickness">{{ item.thickness }}</a>
								</td>
								<td><a href="#" class="xedit" id="finish" data-type="text" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Finish">{{ item.fin.name }}</a></td>
								<td><a href="#" class="xedit" id="lengths" data-type="text" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Lengths / Notes">{{ item.lengths }}</a></td>
								<td><a href="#" class="xedit" id="qty" data-type="text" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Quantity">{{ item.qty }}</a></td>
								<td><a href="#" class="xedit" id="unitPrice" data-type="select" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Pricing Method">{{ item.unit.name }}</a></td>
								<td><a href="#" class="xedit" id="price" data-type="text" data-pk="{{ item.id }}" data-url="/quotes/edititem" data-title="Price">{{ item.unitPrice }}</a></td>
								<td>
									{{ link_to('quotes/deleteitem/' ~ item.id, 'Delete')}}
									
								</td>
							</tr>
							{% endfor %}
							<tr>
								{{ form('quotes/createitem', 'method': 'post') }}
									<td hidden="true">{{ form.render('quoteId') }}</td>
									<td>{{ form.render('grade') }}</td>
									<td>{{ form.render('width') }} {{ form.render('thickness') }}</td>
									<td>{{ form.render('finish') }} </td>
									<td>{{ form.render('lengths') }} </td>
									<td>{{ form.render('qty') }} </td>
									<td>{{ form.render('priceMethod') }} </td>
									<td>{{ form.render('price') }} </td>
									<td>
										<button type="submit" class="btn btn-primary">Save</button>
									</td>
								{{ end_form() }}
							</tr>
						</tbody>
						<tfoot>
							<tr>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>