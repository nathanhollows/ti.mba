{{ content() }}

<form action="{{ static_url('followup/create') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
			<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-building"></i> 
					</div>
					{{ form.render('customerCode') }}
				</div>
			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-user"></i> 
					</div>
					{{ form.render('contact') }}
				</div>
			</div>
			<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-quote-left"></i> 
					</div>
					{{ form.render('job') }}
				</div>
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-calendar"></i> 
					</div>
					{{ form.render('date') }}
				</div>
			</div>	
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-user"></i> 
					</div>
					{{ form.render('user') }}
				</div>
			</div>	
		</div>

		<hr>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				{{ form.render('details') }}
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-default active">
						<input type="radio" name="type" value="13" autocomplete="off" checked> Note
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="14" autocomplete="off"> Phone
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="3" autocomplete="off"> Email
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="4" autocomplete="off"> Rep Visit
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="5" autocomplete="off"> Quote
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="6" autocomplete="off"> Other
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="7" autocomplete="off"> Mail
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="11" autocomplete="off"> Dispute
					</label>
					<label class="btn btn-default">
						<input type="radio" name="type" value="12" autocomplete="off"> Gift
					</label>
				</div>
			</div>	
		</div>
	</div>