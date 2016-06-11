<ul class="pager">
	<li>{{ link_to('kpi/' ~ yesterday, 'Previous') }}</li>
	<li>{{ link_to('kpi/', 'Today') }}</li>
	<li>{{ link_to('kpi/' ~ tomorrow, 'Next') }}</li>
</ul>

{{ flashSession.output() }}

{{ content() }}
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3">
	
<h2>{{ date( 'l dS M', strtotime(date) ) }}</h2>

<form action="/kpi/save" method="POST" role="form">

	<div class="form-group">
	{{ hidden_field('date', 'test', 'value': date ) }}
	{% for element in form %}
		{{ element.label() }}
		{{ element.render() }}
	{% endfor %}	
	</div>

	<button type="submit" class="btn btn-primary">Submit</button>
</form>
{% endif %}