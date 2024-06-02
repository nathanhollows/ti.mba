{{ form("address/create", "method":"post", "autocomplete" : "off") }}
	{{ content() }}

	{% for element in form %}
	<div class="form-group">
		{% if element.getName() not in ["id", "customerCode"] %}
			{{ element.label() }}
		{% endif %}
		{{ element }}
	</div>    
	{% endfor %}
	<div class="row">
		<div class="col">
			<button type="submit" class="btn btn-primary">Save</button>
		</div>
	</div>

	</form>
