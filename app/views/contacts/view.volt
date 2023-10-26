{{ content() }}

<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Contact Details
			<a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('contacts/edit/' ~ contact.id) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i></a>
			</h3>
		</div>
		<div class="panel-body">
			{{ contact.name }}<br>
			{% if contact.email is not empty %} <a href="mailto:{{ contact.email }}">{{ contact.email }}</a><br> {% endif %}
			{% if contact.directDial is not empty %} <a href="tel:{{ contact.directDial }}" class="tel-link">{{ contact.directDial }}</a><br> {% endif %}
            {% if contact.role is defined %}
			    {% if contact.role is numeric %}
                    {{ contact.job.name }}<br>
                {% endif %}
            {% endif %}
		</div>
	</div>
	{% if contact.company is not empty %}
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Organisation</h3>
		</div>
		<div class="panel-body">
			{{ link_to("customers/view/" ~ contact.company.customerCode, contact.company.name) }}<br>
			<a href="tel:{{ contact.company.phone }}" class="tel-link">{{ contact.company.phone }}</a>
		</div>
	</div>
	{% endif %}
</div>

<div class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
	<div class="row">

		{{ partial('timeline') }}

	</div>
</div>
