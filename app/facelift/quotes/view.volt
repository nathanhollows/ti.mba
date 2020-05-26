<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Quote {{ quote.quoteId }}</h6>
				<h4 class="header-title">
					<a href="#" class="xedit" id="reference" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-mode="inline" data-title="Reference">{{ quote.reference }}</a><br />
				</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group shadow">
					{{ linkTo(["quote/won", "Won",  "class": "btn btn-success btn-sm "]) }}
					{{ linkTo(["quote/lost", "Lost",  "class": "btn btn-secondary btn-sm "]) }}
				</div>
				{{ linkTo(['quote/get/' ~ quote.webId, 'Get PDF', 'class': 'btn btn-primary shadow']) }}
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
				<dd><span class="badge badge-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span></dd>
				<dt>Attention</dt>
				<dd>{% if quote.customerContact is not empty %}{{ quote.customerContact.name }} {% endif %}</dd>
				<dt>Rep</dt>
				<dd><a href="#" class="xedit" id="rep" data-mode="inline" data-type="select" data-source="[ {% for user in users %}{value: {{user.id}}, text: '{{ user.name }}'},{% endfor %} ]" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Sales Rep" data-value="{{ quote.rep.id }}">{{ quote.rep.name }}</a></dd>
			</dl>
		</div>

		<div class="col pt-4">
			<dl>
				<dt>Lead time<dt>
				<dd>
				<a href="#" class="xedit" data-mode="inline" id="leadTime" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Lead Time">{{ quote.leadTime }}</a>
				</dd>
				<dt>Date</dt>
				<dd>
				<a href="#" class="xedit" data-mode="inline" id="date" data-type="date" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Date" data-placement="bottom">{{ quote.date }}</a>
</dd>
				<dt>Validity Period</dt>
				<dd><a href="#" class="xedit" data-mode="inline"  id="validity" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Vailidity">{{ quote.validity }}</a> days</dd>
				<dt>Freight</dt>
				<dd>$<a href="#" class="xedit" data-mode="inline" id="freight" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Freight">{{ quote.freight }}</a></dd>
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
		<div class="col">
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
								{{ select_static(['grade[]', grades, 'using': ['shortCode', 'name'], 'value': item.grade, 'class': 'data grade', 'data-live-search': 'true', 'data-container': 'body']) }}
							</td>
							<td>{{ select_static(['treatment[]', treatment, 'using': ['shortCode', 'shortCode'], 'value': item.treatment, 'class': 'data treatment' , 'data-live-search': 'true', 'data-container': 'body']) }}</td>
							<td>{{ select_static(['dryness[]', dryness, 'using': ['shortCode', 'shortCode'], 'value': item.dryness, 'class': 'data dryness', 'data-live-search': 'true', 'data-container': 'body']) }}</td>
							<td>
								{{ numeric_field('width[]', 'value': item.width, 'class': 'data width') }}
							</td>
							<td>
								{{ numeric_field('thickness[]', 'value': item.thickness, 'class': 'data thickness') }}
							</td>
							<td>
								{{ select_static(['finish[]', finishes, 'using': ['id', 'name'], 'value': item.finish, 'class': 'data']) }}
							</td>
							<td>
								{{ text_field('lengths[]', 'value': item.lengths) }}
							</td>
							<td>
								{{ numeric_field('qty[]', 'value': item.qty, 'step': 'any', 'class': 'qty') }}
							</td>
							<td>
								{{ select_static(['priceMethod[]', priceMethod, 'using': ['id', 'name'], 'value': item.priceMethod, 'class': 'data priceMethod']) }}
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
								{{ select_static(['finish[]', finishes, 'using': ['id', 'name'], 'class': 'data', 'useEmpty': true]) }}
							</td>
							</td>
							<td>
								{{ text_field('lengths[]', 'placeholder': 'Notes / Lengths') }}
							</td>
							<td>
								{{ numeric_field('qty[]', 'step': 'any', 'placeholder': 'Qty', 'class': 'qty') }}
							</td>
							<td>
								{{ select_static(['priceMethod[]', priceMethod, 'using': ['id', 'name'], 'class': 'data priceMethod', 'useEmpty': false]) }}
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
				<button type="submit" class="btn btn-primary shadow float-right">Update</button>
			</form>
		</div>
	</div>
</div>

<div class="container d-block d-lg-none">
	<div class="row">
		<div class="col">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Item Summary</h5>
				</div>
				<ul class="list-group list-group-flush">
					{% for item in quote.items %}
					<li class="list-group-item">
						<strong>{{ loop.index }}.</strong> {{ item.width }} x {{ item.thickness }} {{ item.grade }} {{ item.treatment }} {{ item.dryness }} {{ item.fin.name }} 
						<span class="float-right">${{ item.price }} {{ item.unit.name }}</span>
						{% if item.lengths %}
						<br />
						<i>{{ item.lengths }}</i>
						{% endif  %}
					</li>
					{% endfor %}
				</ul>
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
	<script>
		$( document ).ready( function() {
			$('.xedit').editable();
		});
	</script>
