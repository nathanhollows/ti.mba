{{ content() }}

{{ form("customers\search") }}

	<legend>Search Customers</legend>

	{% for element in form %}
	<div class="form-group">
		{{ element.label() }}
		{{ element }}
	</div>
	{% endfor %}

	{{ submit_button("Search", "class": "btn btn-primary")}}
</form>
