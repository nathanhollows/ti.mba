{{ content() }}

<form action="{{ static_url('/followup/create') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-building"></i> 
					</div>
					{{ form.render('customerCode') }}
				</div>
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-user"></i> 
					</div>
					{{ form.render('contact') }}
				</div>
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-quote-left"></i> 
					</div>
					{{ form.render('job') }}
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
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-quote-left"></i> 
					</div>
					{{ form.render('reference') }}
				</div>
			</div>
		</div>

		<hr>

		<div class="row">
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<label>Record Date</label> <br>
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-calendar"></i> 
					</div>
					{{ form.render('followUpDate') }}
				</div>
			</div>	
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<label>Remind Me</label> <br>
				<div class="input-group">
					<span class="input-group-addon">
						<input type="checkbox" name="remind" aria-label="...">
					</span>
					<input type="date" class="form-control" name="followUpDate" aria-label="..." value="{{ date('Y-m-d') }}">
				</div><!-- /input-group -->
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
					<label class="btn btn-small btn-default active">
						<input type="radio" name="contactType" value="13" autocomplete="off" checked> Note
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="1" autocomplete="off"> Phone In
					</label>

					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="2" autocomplete="off"> Phone Out
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="3" autocomplete="off"> Email
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="4" autocomplete="off"> Rep Visit
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="15" autocomplete="off"> ETA
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="6" autocomplete="off"> Other
					</label>
					<label class="btn btn-small btn-default">
						<input type="radio" name="contactType" value="5" autocomplete="off"> Quote
					</label>
				</div>
			</div>	
		</div>
	</div>
