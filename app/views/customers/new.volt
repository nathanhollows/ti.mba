{{ content() }}

{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">General Info</h3>
		</div>
		<div class="panel-body">


			{% for element in form %}
			<div class="form-group">
				{{ element.label(['class': 'col-md-3 control-label']) }}
				<div class="col-md-9">
					{{ element }}
				</div>
			</div>
			{% endfor %}

		</div>
	</div>
</div>

{{ submit_button('Save', 'class': 'btn btn-default') }}

</form>