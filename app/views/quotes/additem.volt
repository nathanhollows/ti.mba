<form action="{{ static_url('quotes/createitem') }}" method="POST" role="form">
	<div class="modal-body">
				{{ form.render('quoteId') }}
				{{ form.render('id') }}
		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('width') }}
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('thickness') }}
			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('grade') }}
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('finish') }}
			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('treatment') }}
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('dryness') }}
			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
			{{ form.render('price') }}
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				{{ form.render('priceMethod') }}
			</div>
		</div>

		<br>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				{{ form.render('lengths') }}
			</div>
		</div>

	</div>