{{ content() }}

<form action="{{ static_url('followup/update') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					{{ form.render('id') }}
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
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
				<div class="input-group">
					<div class="input-group-addon">
						<i class="fa fa-quote-left"></i>
					</div>
					{{ form.render('job') }}
				</div>
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
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
					{{ form.render('date') }}
				</div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<label>Remind Me</label> <br>
				<div class="input-group">
					<span class="input-group-addon">
						{% if details.completed is empty %}
							<input type="checkbox" name="remind" aria-label="..." checked="true">
						{% else %}
							<input type="checkbox" name="remind" aria-label="...">
						{% endif %}
					</span>
						{% if details.followUpDate is empty %}
							<input type="date" class="form-control" name="followUpDate" aria-label="..." value="{{ date('Y-m-d') }}">
						{% else %}
							<input type="date" class="form-control" name="followUpDate" aria-label="..." value="{{ details.followUpDate }}">
						{% endif %}
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
					<label class="btn btn-small btn-default  {% if record.type.id == 13 %} active {% endif %}">
						<input type="radio" name="contactType" value="13" autocomplete="off" {% if record.type.id == 13 %} checked {% endif %}> Note
					</label>
					<label class="btn btn-small btn-default {% if record.type.id == 1 %} active {% endif %}">
						<input type="radio" name="contactType" value="1" autocomplete="off" {% if record.type.id == 1 %} checked {% endif %}> Phone In
					</label>

					<label class="btn btn-small btn-default {% if record.type.id == 2 %} active {% endif %}">
						<input type="radio" name="contactType" value="2" autocomplete="off" {% if record.type.id == 2 %} checked {% endif %}> Phone Out
					</label>
					<label class="btn btn-small btn-default {% if record.type.id == 3 %} active {% endif %}">
						<input type="radio" name="contactType" value="3" autocomplete="off" {% if record.type.id == 3 %} checked {% endif %}> Email
					</label>
					<label class="btn btn-small btn-default {% if record.type.id == 4 %} active {% endif %}">
						<input type="radio" name="contactType" value="4" autocomplete="off" {% if record.type.id == 4 %} checked {% endif %}> Rep Visit
					</label>
					<label class="btn btn-small btn-default" {% if record.type.id == 15 %} active {% endif %}>
						<input type="radio" name="contactType" value="15" autocomplete="off" {% if record.type.id == 15 %} checked {% endif %}> ETA
					</label>
					<label class="btn btn-small btn-default {% if record.type.id == 6 %} active {% endif %}">
						<input type="radio" name="contactType" value="6" autocomplete="off" {% if record.type.id == 6 %} checked {% endif %}> Other
					</label>
					<label class="btn btn-small btn-default {% if record.type.id == 5 %} active {% endif %}">
						<input type="radio" name="contactType" value="5" autocomplete="off" {% if record.type.id == 5 %} checked {% endif %}> Quote
					</label>
				</div>
			</div>
		</div>
	</div>
