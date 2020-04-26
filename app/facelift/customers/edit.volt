{{ content() }}

<form action="{{ static_url('customers/update') }}" method="POST" role="form">
		<div class="row">
		{% for element in form %}
			<div class="col-12 col-md-6">
				<div class="form-group">
					{{ element.label() }}
					{{ element }}
				</div>
			</div>
		{% endfor %}
		</div>
		<div class="row">
			<div class="col">
				<button class="btn btn-primary" type="submit">Save</button>
			</div>
		</div>
</form>
