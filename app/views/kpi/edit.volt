{{ content() }}

<ul class="pager">
	<li>{{ link_to('kpi/' ~ yesterday, 'Previous') }}</li>
	<li>{{ link_to('kpi/', 'Today') }}</li>
	<li>{{ link_to('kpi/' ~ tomorrow, 'Next') }}</li>
</ul>

{% if form is not empty %}
<form action="/kpi/save" method="POST" role="form">

	<div class="form-group">
	{% for element in form %}
		{{ element.label() }}
		{{ element.render() }}
	{% endfor %}	
	</div>

	<button type="submit" class="btn btn-primary">Submit</button>
</form>
{% endif %}