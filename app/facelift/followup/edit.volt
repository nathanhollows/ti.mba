{{ content() }}

<form action="{{ static_url('followup/update') }}" method="POST" role="form">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			{{ form.label('reference') }}
			{{ form.render('reference') }}
		</div>
		<div class="col-xs-12 col-sm-6">
			{{ form.label('contact') }}
			{{ form.render('contact') }}
		</div>
	</div>
	<div class="row">
		<div class="col">
			{{ form.label('details') }}
			{{ form.render('details') }}
			<div class="invalid-feedback">
				This cannot be left empty
			</div>
		</div>
	</div>

	<div class="row my-3">
		<div class="col">
			<div class="btn-group w-100" data-toggle="buttons">
				<label class="btn btn-small btn-outline-secondary btn-sm">
					<input type="radio" name="contactType" value="1" autocomplete="off" hidden> Phone In
				</label>
				<label class="btn btn-small btn-outline-secondary btn-sm">
					<input type="radio" name="contactType" value="2" autocomplete="off" hidden> Phone Out
				</label>
				<label class="btn btn-small btn-outline-secondary btn-sm active">
					<input type="radio" name="contactType" value="13" autocomplete="off" checked hidden> Note
				</label>
				<label class="btn btn-small btn-outline-secondary btn-sm">
					<input type="radio" name="contactType" value="3" autocomplete="off" hidden> Email
				</label>
				<label class="btn btn-small btn-outline-secondary btn-sm">
					<input type="radio" name="contactType" value="4" autocomplete="off" hidden> Rep Visit
				</label>
				<label class="btn btn-small btn-outline-secondary btn-sm">
					<input type="radio" name="contactType" value="6" autocomplete="off" hidden> Other
				</label>
			</div>
		</div>	
	</div>

	{{ form.render('id') }}
	{{ form.render('user') }}
	{{ form.render('customerCode') }}
	{{ form.render('job') }}

	<div class="row">
		<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
			<label>Record Date</label> <br>
			<div class="input-group">
				{{ form.render('recordDate') }}
			</div>
		</div>	
		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
			<label for="remind">Set Reminder?</label> <br>
			<label class="sr-only" for="inlineFormInputGroup">Username</label>
			<div class="input-group mb-2">
				<div class="input-group-prepend">
					<div class="input-group-text">
						<input type="checkbox" id="remind" name="remind" aria-label="Remind me">
					</div>
				</div>
				{{ form.render('followUpDate') }}
			</div>
			<div class="input-group">
				<span class="input-group-addon">
				</span>
			</div><!-- /input-group -->
		</div>
	</div>

