{{ form("contacts/create", "method":"post", "autocomplete" : "off", "class": "needs-validation") }}
	{{ content() }}

	{% for element in form %}
	{% if element.getName() not in ["id", "customerCode"] %}
	<div class="form-group">
		{{ element.label() }}
		{% if !element.getAttribute("required") %}
		<small class="text-muted">Optional</small>
		{% endif %}
		{{ element }}
	</div>
	{% else %}
	{{ element }}
	{% endif %}
	{% endfor %}

	<div class="row">
		<div class="col">
			<button type="submit" class="btn btn-primary">Save</button>
		</div>
	</div>
</form>
