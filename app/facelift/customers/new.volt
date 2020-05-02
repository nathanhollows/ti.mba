<div class="container">
	<div class="col-12 offset-md-2 col-md-8">
	<div class="header py-3">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">New Customer</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
		<hr class="w-100">
	</div>


	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>

	{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

	<div class="row">
		<div class="col col-md-9">
			<div class="form-group">
				{{ form.label('customerName',['class': 'control-label']) }}
				{{ form.render('customerName') }}
				<small class="form-text text-muted">Required</small>
			</div>
		</div>
		<div class="col">
			<div class="form-group">
				{{ form.label('customerCode',['class': 'control-label']) }}
				{{ form.render('customerCode') }}
				<small class="form-text text-muted">Required</small>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="form-group">
				{{ form.label('phone',['class': 'control-label']) }}
				{{ form.render('phone') }}
			</div>
		</div>
		<div class="col">
			<div class="form-group">
				{{ form.label('fax',['class': 'control-label']) }}
				{{ form.render('fax') }}
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="form-group">
				{{ form.label('email',['class': 'control-label']) }}
				{{ form.render('email') }}
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="form-group">
				{{ form.label('customerStatus',['class': 'control-label']) }}
				{{ form.render('customerStatus') }}
			</div>
		</div>
		<div class="col">
			<div class="form-group">
				{{ form.label('area',['class': 'control-label']) }}
				{{ form.render('area') }}
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			{{ submit_button('Save', 'class': 'btn btn-primary') }}
			</form>
		</div>
	</div>
</div>
