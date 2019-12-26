<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Create</h6>
				<h4 class="header-title">Customer</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
		<hr class="w-100">
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}
			{% for element in form %}
			<div class="form-group">
				{{ element.label(['class': 'col-md-3 control-label']) }}
					{{ element }}
			</div>
			{% endfor %}
			{{ submit_button('Save', 'class': 'btn btn-primary') }}
			</form>
		</div>
	</div>
</div>
