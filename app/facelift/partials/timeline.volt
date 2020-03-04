{# Display pending contact records, if any #}
{% if futureHistory is not empty %}
<div class="timeline-centered">
	{% for line in futureHistory %}
	<div class="card mb-3 border-danger">
		<div class="card-body">
			{% if line.job is defined %}
			<h5 class="card-title">{{ line.type.name }} - {{ linkTo('quotes/view/' ~ line.job, line.reference) }}</h5>
			{% else %}
			<h5 class="card-title">{{ line.type.name }} - {{ line.reference }}</h5>
			{% endif %}
			<h6 class="card-subtitle mb-2 text-muted">{{ line.staff.name }} - {{ date('d M Y', strtotime(line.date)) }}</h6>
			{% if line.contact is not empty %}
			<span class="float-right">{{ line.person.name }}</span>
			{% endif %}
			<p class="card-text">{{ parser.parse(line.details)|nl2br }}
			{% if line.followUpNotes %} <br /> {{ line.followUpNotes }} {% endif %}</p>
			Follow up: {{ date('d M Y', strtotime(line.followUpDate)) }}
			<a href="{{ url('followup/delete/' ~ line.id) }}" class="card-link text-danger float-right">Delete</a>
			<a href="{{ url('followup/edit/' ~ line.id) }}" class="card-link float-right mr-3">Edit</a>
			<a href="#" class="card-link float-right">Mark as Done</a>
		</div>
	</div>
	{% endfor %}
</div>
{% endif %}

<div class="row">

	{# Show the filters #}
	{% if history|length is not 0 %}

	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="timeline-centered" id="thetimeline">
			{% for line in history %}
			{% if line.followUpDate %}
			{% continue %}
			{% endif %}
			<div class="card mb-3">
				<div class="card-body">
					{% if line.job is defined %}
					<h5 class="card-title">{{ line.type.name }} - {{ linkTo('quotes/view/' ~ line.job, line.reference) }}</h5>
					{% else %}
					<h5 class="card-title">{{ line.type.name }} - {{ line.reference }}</h5>
					{% endif %}
					<h6 class="card-subtitle mb-2 text-muted">{{ line.staff.name }} - {{ date('d M Y', strtotime(line.date)) }}</h6>
					{% if line.contact is not empty %}
					<span class="float-right">{{ line.person.name }}</span>
					{% endif %}
					<p class="card-text">{{ parser.parse(line.details)|nl2br }}
					{% if line.followUpNotes %} <br /> {{ line.followUpNotes }} {% endif %}</p>
					{% if line.followUpDate %}Follow up: {{ date('d M Y', strtotime(line.followUpDate)) }}{% endif %}
					<a href="{{ url('followup/delete/' ~ line.id) }}" class="card-link text-danger float-right">Delete</a>
					<a href="{{ url('followup/edit/' ~ line.id) }}" class="card-link float-right mr-3">Edit</a>
					<a href="#" class="card-link float-right">Mark as Done</a>
				</div>
			</div>
			{% endfor %}
		</div>
	</div>
	{% else %}
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="timeline-centered" id="thetimeline">
			<article class="timeline-entry" data-groups='["all", "{{ line.type.id }}"]'>

				<div class="timeline-entry-inner">

					<div class="timeline-icon bg-{{ line.type.style }}">
						<i class="fa fa-icon fa-{{ line.type.icon }}"></i>
					</div>

					<div class="timeline-label">
						<div class="timeline-content">
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


			<article class="timeline-entry begin">

				<div class="timeline-entry-inner">

					<div class="timeline-icon" style="-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);">

					</div>

				</div>

			</article>

		</div>
	</div>
	{% endif %}

</div>
