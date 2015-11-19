{{ form("customers") }}

	<legend>Search Customers</legend>

	{% for element in form %}
	<div class="form-group">
		{{ element.label() }}
		{{ element }}
	</div>
	{% endfor %}

	<button type="submit" class="btn btn-primary">Submit</button>
</form>