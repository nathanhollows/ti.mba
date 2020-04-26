<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Quote {{ quote.quoteId }}</h6>
				<h4 class="header-title">{{ quote.reference }}</h4>
			</div>
			<div class="col text-right">
				{{ linkTo(['quote/get/' ~ quote.webId, 'Get PDF', 'class': 'btn btn-primary']) }}
			</div>
			<hr class="w-100"/>
		</div>
	</div>
</div>

<div class="container">
	{{ content() }}
	{{ flashSession.output() }}
	<div class="row">
		<div class="col">
			<h5>Overview</h5>
			<dl>
				<dt>Status</dt>
				<dd>{{ quote.genericStatus.statusName }}</dd>
				<dt>Attention</dt>
				<dd>{% if quote.customerContact is not empty %}{{ quote.customerContact.name }} {% endif %}</dd>
				<dt>Rep</dt>
				<dd>{{ quote.rep.name }}</dd>
			</dl>
		</div>

		<div class="col pt-4">
			<dl>
				<dt>Date</dt>
				<dd>{{ quote.date }}</dd>
				<dt>Validity Period</dt>
				<dd>{{ quote.validity }} days</dd>
				<dt>Freight</dt>
				<dd>${{ quote.freight }}</dd>
			</dl>
		</div>

		<div class="col">
			<h5>Notes</h5>
			<dl>
				<dt>Notes to Customer</dt>
				<dd>{{ quote.notes }}</dd>
				<dt>Private notes</dt>
				<dd>{{ quote.moreNotes }}</dd>
			</dl>
		</div>
	</div>
</div>

<div class="container-fluid bg-white border-top border-bottom shadow py-3 my-3 d-none d-lg-block">
	<div class="row">
		<div class="col-md-12 col-lg-12">
			<form action="/quotes/saveitems" method="POST" role="form" id="items">
				<table data-navigable-spy data-editable data-editable-spy class="table table-hover">
					<thead>
						<tr>
							<th>Grade</th>
							<th>Treatment</th>
							<th>Dryness</th>
							<th>Width</th>
							<th>Thick</th>
							<th>Finish</th>
							<th>Notes</th>
							<th>Qty</th>
							<th>Unit</th>
							<th>Price</th>
						</tr>
					</thead>
					<tbody>
						{# Loop through the quote items #}
						{{ hidden_field('quoteId', 'value': quote.quoteId) }}
						{% for item in items %}
						<tr class="record">
							<td>
								{{ hidden_field('id[]', 'value': item.id) }}
								{{ select_static('grade[]', grades, 'using': ['shortCode', 'name'], 'value': item.grade, 'class': 'data grade', 'data-live-search': 'true', 'data-container': 'body') }}
							</td>
							<td>{{ select_static('treatment[]', treatment, 'using': ['shortCode', 'shortCode'], 'value': item.treatment, 'class': 'data treatment' , 'data-live-search': 'true', 'data-container': 'body') }}</td>
							<td>{{ select_static('dryness[]', dryness, 'using': ['shortCode', 'shortCode'], 'value': item.dryness, 'class': 'data dryness', 'data-live-search': 'true', 'data-container': 'body') }}</td>
							<td>
								{{ numeric_field('width[]', 'value': item.width, 'class': 'data width') }}
							</td>
							<td>
								{{ numeric_field('thickness[]', 'value': item.thickness, 'class': 'data thickness') }}
							</td>
							<td>
								{{ select_static('finish[]', finishes, 'using': ['id', 'name'], 'value': item.finish, 'class': 'data') }}
							</td>
							<td>
								{{ text_field('lengths[]', 'value': item.lengths ) }}
							</td>
							<td>
								{{ numeric_field('qty[]', 'value': item.qty, 'step': 'any', 'class': 'qty') }}
							</td>
							<td>
								{{ select_static('priceMethod[]', priceMethod, 'using': ['id', 'name'], 'value': item.priceMethod, 'class': 'data priceMethod') }}
							</td>
							<td>
								{{ numeric_field('unitPrice[]', 'value': item.price, 'step': 'any') }}
							</td>
							<td>
								<a href="#" data-href="/quotes/deleteitem/{{ item.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete"><i class="fa fa-times"></i></a>
							</td>
						</tr>
						{% endfor %}
						<tr>
							<td>
								{{ hidden_field('id[]') }}
								{{ form.render('grade[]') }}
							</td>
							<td>{{ form.render('treatment[]') }}</td>
							<td>{{ form.render('dryness[]') }}</td>
							<td>
								{{ numeric_field('width[]', 'placeholder': 'Width', 'class': 'data width') }}
							</td>
							<td>
								{{ numeric_field('thickness[]', 'placeholder': 'Thickness', 'class': 'data thickness') }}
							</td>
							<td>
								{{ select_static('finish[]', finishes, 'using': ['id', 'name'], 'class': 'data', 'useEmpty': true) }}
							</td>
							</td>
							<td>
								{{ text_field('lengths[]', 'placeholder': 'Notes / Lengths') }}
							</td>
							<td>
								{{ numeric_field('qty[]', 'step': 'any', 'placeholder': 'Qty', 'class': 'qty') }}
							</td>
							<td>
								{{ select_static('priceMethod[]', priceMethod, 'using': ['id', 'name'], 'class': 'data priceMethod', 'useEmpty': false) }}
							</td>
							<td>
								{{ numeric_field('unitPrice[]', 'step': 'any', 'placeholder': 'Price') }}
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th>Grade</th>
							<th>Treatment</th>
							<th>Dryness</th>
							<th>Width</th>
							<th>Thick</th>
							<th>Finish</th>
							<th>Notes</th>
							<th>Qty</th>
							<th>Unit</th>
							<th>Price</th>
						</tr>
					</tfoot>
				</table>
				<button type="submit" class="btn btn-primary">Update</button>
			</form>
		</div>
	</div>
</div>

<div class="container d-md-none">
	<div class="row">
		<hr class="w-100"/>
		<div class="col">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Item summary</h3>
				</div>
				<div class="panel-body">
					{% for item in quote.items %}
					<strong>{{ loop.index }}.</strong> {{ item.width }} x {{ item.thickness }} {{ item.grade }} {{ item.treatment }} {{ item.dryness }} {{ item.fin.name }} ${{ item.price }} {{ item.unit.name }}
					{% if item.lengths %}
					<br />
					<i>{{ item.lengths }}</i>
					{% endif  %}
					<hr />
					{% endfor %}
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container">
	{{ partial('timeline') }}
</div>

	<style type="text/css">
#rowToClone {
	display: none;
}

#items td {
	padding: 0;
}

.priceMethod {
	min-width: 58px;
}

#items select, #items input {
	width: 100%;
	padding: 8px;
}
#items input[type='number'] {
	max-width: 80px;
}
span.quote-deets {
	width: 90px;
	display: block;
	float: left;
}
span.block {
	display: inline-table;
}
select.data {
	background: transparent;
	border: 0;
}
.record:hover a.delete, .active a.delete {
	visibility: visible;
}

a.delete {
	visibility: hidden;
}

select.data.grade {
	width: 170px;
}
select.data.treatment {
	width: 72px;
}
select.data.dryness {
	width: 54px;
}
	</style>
	<script src="/js/editable-table.js"></script>
