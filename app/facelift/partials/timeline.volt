{% if futureHistory is not empty %}
{% if futureHistory|length is not 0 %}
{# Notes that needs to be followed up will go here #}
{% endif %}
{% endif %}


{% if history|length is not 0 %}
<div class="row">
	<div class="col">
		{% for line in history %}
		<div class="card mb-3 w-100">
			<div class="card-body">
				{% set cardTitle = line.reference %}
				{% if line.job is not null %}
					{% set cardTitle = linkTo(['quotes/view/' ~ line.job, line.reference]) %}
				{% endif %}
				<h5 class="card-title">{{ cardTitle }}</h5>
				{% if line.contact is not empty %}
				<h6 class="card-subtitle mb-2 text-muted">{{ line.person.name }}</h6>
				{% endif %}
				<p class="card-text">{{ parser.parse(line.details) }}
				{% if line.followUpNotes %}
					{{ line.followUpNotes }}
				{% endif %}</p>
				<a href="#" class="card-link">Card link</a>
				<a href="#" class="card-link">Another link</a>
			</div>
		</div>
		{% endfor %}
	</div>
</div>
		<h2>{% if line.user %}{{ line.staff.name }}{% endif %} <span>{{ line.type.name }}</span>
		</h2>
	</div>
	<p>{{ date('d M Y', strtotime(line.date)) }} {% if line.completed is null %} <i class="text-primary fa fa-icon fa-bell"></i> {{ date('d M Y', strtotime(line.followUpDate)) }} {% endif %}
	<span class="pull-right">
		<a href="#" data-href="{{ url('followup/delete/' ~ line.id) }}" data-toggle="modal" data-target="#confirm-delete" class="text-danger"><i class="fa fa-times"></i> Delete</a> &nbsp;
		<a class="text-info" data-target="#modal-ajax" href='{{ url('followup/edit/' ~ line.id) }}' data-target="#modal-ajax"> <i class="fa fa-pencil"></i> Edit</a>
	</span>                            </p>

	{% else %}
	<div class="col">


		<h2>There doesn't seem to be anything here!</h2>
		<p>Click here to
		{% if quote is not empty %}
		<a class="text-info" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ quote.customerCode ~ '&job=' ~ quote.quoteId) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> add a record</a>
		{% elseif contact is not empty %}
		<a class="text-info" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ contact.customerCode ~ '&contact=' ~ contact.id) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> add a record</a>
		{% elseif customer is not empty %}
		<a class="text-info" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> add a record</a>
		{% else %}
		<a class="text-info" data-target="#modal-ajax" href='{{ url('followup/') }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> add a record</a>
		{% endif %}
		</p>
	</div>
</div>
</div>

</article>

</div>
</div>
{% endif %}

</div>
