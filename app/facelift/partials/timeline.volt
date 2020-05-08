{# Display pending contact records, if any #}
{% if futureHistory is not empty %}
<div class="timeline-centered">
	{% for line in futureHistory %}
	{% if line.type.name is "Quote Made" %}
	<p class="px-3 py-3 d-block">
	<strong>
		Quote {{ linkTo('quotes/view/' ~ line.job, line.reference) }} 
		{% if line.quote %}
		<span class="badge badge-{{ line.quote.genericStatus.style }}">{{ line.quote.genericStatus.statusName }}</span>
		{% endif %}
		made by {{ line.staff.name }} 
	</strong>
	<span class="float-right">
		{{ date('d M Y', strtotime(line.date)) }}
	</span>
	</p>
	{% continue %}
	{% endif %}
	<div class="card mb-3 border-danger shadow-sm">
		<div class="card-body">
			{% if line.job is defined %}
			<strong class="card-title">{{ line.type.name }} - {{ linkTo('quotes/view/' ~ line.job, line.reference) }}</strong>
			{% else %}
			<strong class="card-title">{{ line.type.name }} 
				{% if line.reference is not null %}- {{ line.reference }}{% endif %}</strong>
			{% endif %}
			{% if line.contact is not empty %}
			<span class="float-right">{{ line.person.name }}</span>
			{% endif %}
			<p class="card-text">{{ parser.parse(line.details|nl2br)}}
		</div>
		<div class="card-footer">
			{{ line.staff.name }} ~ {{ date('d M Y', strtotime(line.date)) }}
			<img src="/img/icons/bell.svg" role="presentation" style="width:1em;">
			{{ date('d M Y', strtotime(line.followUpDate)) }}
			<a href="{{ url('followup/delete/' ~ line.id) }}" class="card-link text-danger float-right confirm-delete">Delete</a>
			<a href="{{ url('followup/edit/' ~ line.id ~ '?facelift') }}" class="card-link float-right mr-3 open-modal">Edit</a>
			<a href="{{ url('followup/complete/' ~ line.id) }}" class="card-link float-right">Done</a>
		</div>
	</div>
	{% endfor %}
</div>
{% endif %}

<div class="row">

	{% if history|length is not 0 %}
	<div class="col">
		<div class="timeline-centered" id="thetimeline">
			{% for line in history %}
			{% if line.completed is null %}
			{% continue %}
			{% endif %}
			{% if line.type.name is "Quote Made" %}
			<p class="px-3 py-3 d-block">
			<strong>
				Quote {{ linkTo('quotes/view/' ~ line.job, line.reference) }} 
				{% if line.quote %}
				<span class="badge badge-{{ line.quote.genericStatus.style }}">{{ line.quote.genericStatus.statusName }}</span>
				{% endif %}
				made by {{ line.staff.name }} 
			</strong>
			<span class="float-right">
				{{ date('d M Y', strtotime(line.date)) }}
			</span>
			</p>
			{% continue %}
			{% endif %}
			<div class="card mb-3 shadow-sm border-0">
				<div class="card-body">
					{% if line.job is defined %}
					<strong class="card-title">{{ line.type.name }} - {{ linkTo('quotes/view/' ~ line.job, line.reference) }}</strong>
					{% else %}
					<strong class="card-title">{{ line.type.name }} 
						{% if line.reference is not null %} - {{ line.reference }}{% endif %}</strong>
					{% endif %}
					{% if line.contact is not empty %}
					<span class="float-right">{{ line.person.name }}</span>
					{% endif %}
					<p class="card-text">{{ parser.parse(line.details|striptags) }}
				</div>
				<div class="card-footer">
					{{ line.staff.name }} ~ {{ date('d M Y', strtotime(line.date)) }}
					<a href="{{ url('followup/delete/' ~ line.id) }}" class="card-link text-danger float-right confirm-delete">Delete</a>
					<a href="{{ url('followup/edit/' ~ line.id ~ '?facelift') }}" class="card-link float-right mr-3 open-modal">Edit</a>
				</div>
			</div>
			{% endfor %}
		</div>
	</div>
	{% else %}
	<div class="col">
		<div class="timeline-centered" id="thetimeline">
			<article class="timeline-entry" data-groups='["all", "{{ line.type.id }}"]'>

				<div class="timeline-entry-inner">

					<div class="timeline-icon bg-{{ line.type.style }}">
						<i class="fa fa-icon fa-{{ line.type.icon }}"></i>
					</div>class="card-link text-danger float-right"

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
