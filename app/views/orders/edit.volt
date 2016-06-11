{{ content() }}

<form action="{{ static_url('customers/update') }}" method="POST" role="form">
	<div class="modal-body">
		<div class="row">
		{% for element in form %}
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
				<div class="form-group">
					{{ element.label() }}
					{{ element }}
				</div>
			</div>
		{% endfor %}
		</div>


	</div>