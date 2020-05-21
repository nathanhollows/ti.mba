<div class="row">
	{% if history|length > 0 %}
	<div class="col">
		<div class="timeline-centered" id="thetimeline">
			{% for line in history %}
			{% if line.completed is null %}
			{% set outstanding = true %}
			{% elseif outstanding is defined and outstanding %}
			<hr class="mb-4"/>
			{% set outstanding = false %}
			{% endif %}
			{% if line.type.name is "Quote Made" %}
			<p class="px-3 py-3 d-block">
			<strong>
				Quote {{ linkTo('quotes/view/' ~ line.job, line.reference) }} 
				{% if line.quote %}
				<span class="badge badge-pill badge-{{ line.quote.genericStatus.style }}">{{ line.quote.genericStatus.statusName }}</span>
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
					{% if oustanding is defined and outstanding %}
			<a href="{{ url('followup/complete/' ~ line.id) }}" class="card-link float-right">Done</a>
			{% endif %}
				</div>
			</div>
			{% endfor %}
		</div>
	</div>
	{% else %}
	<div class="col">
		<div class="timeline-centered" id="thetimeline">

			<p class="px-3 py-3 d-block">
			<strong>
				There's no history for this customer. Why not
				{% if quote is not empty %}
				<a class="open-modal" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ quote.customerCode ~ '&job=' ~ quote.quoteId) }}' data-target="#modal-ajax">add a note</a>
				{% elseif contact is not empty %}
				<a class="open-modal" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ contact.customerCode ~ '&contact=' ~ contact.id) }}' data-target="#modal-ajax">add a note</a>
				{% elseif customer is not empty %}
				<a class="open-modal" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ customer.customerCode ~ '&facelift') }}' data-target="#modal-ajax">add a note</a>
				{% else %}
				<a class="open-modal" data-target="#modal-ajax" href='{{ url('followup/') }}' data-target="#modal-ajax">add a note</a>
				{% endif %}?
			</strong>
			</p>
		</div>
	</div>
	{% endif %}

</div>
