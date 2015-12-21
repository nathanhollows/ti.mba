{{ content() }}

{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
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
<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
	<div class="panel panel-success">
		<div class="panel-heading">
			<h3 class="panel-title">Shipping Address</h3>
		</div>
		<div class="panel-body">

			<div class="form-group">
				<div class="col-md-9">
				
				</div>
			</div>

		</div>
	</div>
</div>
<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">Billing Address</h3>
		</div>
		<div class="panel-body">

			<div class="form-group">
				<div class="col-md-9">
				
				</div>
			</div>

		</div>
	</div>
</div>

{{ submit_button('Save', 'class': 'btn btn-default') }}

</form>