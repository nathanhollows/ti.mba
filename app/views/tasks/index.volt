{{ content() }}

<div class="row">
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<h3>Overdue</h3>
		<div class="list-group">
			{% for item in overdue %}
				<li class="list-group-item">
					<div class="row">
						<div class="col-xs-11 col-sm-11 col-md-11 col-lg-11">
							<strong>{{ item.contactReference }}</strong>{{ parser.parse(item.details) }}
						</div>
						<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
							<a href="/followup/complete/{{item.id}}" class="pull-right error"><i class="fa fa-icon fa-times"></i></a>
						</div>
					</div>
				</li>
			{% endfor %}
		</div>
		{% if overdue|length is 0 %}
			<h5> There's nothing to see here!</h5>
		{% endif %}
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<h3>Todays</h3>
		<div class="list-group">
			{% for item in today %}
				<a href="#" class="list-group-item"><strong>{{ item.contactReference }}</strong>{{ parser.parse(item.details) }}</a>
			{% endfor %}
		</div>
		{% if today|length is 0 %}
			<h5> There's nothing to see here! </h5>
		{% endif %}
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<h3>Later</h3>
		<div class="list-group">
			{% for item in coming %}
				<a href="#" class="list-group-item"><strong>{{ item.contactReference }}</strong>{{ parser.parse(item.details) }}</a>
			{% endfor %}
		</div>
		{% if coming|length is 0 %}
			<h5> There's nothing to see here! </h5>
		{% endif %}
	</div>
</div>
