{{ flashSession.output() }}
{{ content() }}

<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3 ">
{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}
			{% for element in form %}
			<div class="form-group">
				{{ element.label(['class': 'col-md-3 control-label']) }}
				<div class="col-md-9">
					{{ element }}
				</div>
			</div>
			{% endfor %}
{{ submit_button('Save', 'class': 'btn btn-default') }}
</div>


</form>