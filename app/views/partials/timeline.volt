{# Display pending contact records, if any #}
{% if futureHistory is not empty %}
{% if futureHistory|length is not 0 %}
<div class="timeline-centered">
    {% for line in futureHistory %}
    <article class="timeline-entry" data-groups='["all", "{{ line.type.id }}"]'>

        <div class="timeline-entry-inner">

            <div class="timeline-icon bg-{{ line.type.style }}">
                <i class="fa fa-icon fa-{{ line.type.icon }}"></i>
            </div>
            <div class="timeline-label">
                <div class="timeline-content">
                    <h2>{% if line.user %}{{ line.staff.name }}{% endif %} <span>{{ line.type.name }}</span>
                        {% if line.contact is not empty %}
                        <span class="pull-right">{{ line.person.name }}</span>
                        {% endif %}
                    </h2>
                    <p><strong><a href="{{ url('/quotes/view/' ~ line.job )}}">{{ line.job }}</a> {{ line.reference }}</strong></p>
                    <p>{{ parser.parse(line.details) }}
                        {% if line.followUpNotes %} <br /> {{ line.followUpNotes }} {% endif %}</p>
                    </div>
                    <div class="timeline-footer">
                        <p>{{ date('d M Y', strtotime(line.date)) }} <i class="text-primary fa fa-icon fa-bell"></i> {{ date('d M Y', strtotime(line.followUpDate)) }}
                            <span class="pull-right">
                                <a href="#" data-href="{{ url('followup/delete/' ~ line.id) }}" data-toggle="modal" data-target="#confirm-delete" class="text-danger"><i class="fa fa-times"></i> Delete</a> &nbsp;
                                <a class="text-info" data-target="#modal-ajax" href='{{ url('followup/edit/' ~ line.id) }}' data-target="#modal-ajax"> <i class="fa fa-pencil"></i> Edit</a>
                            </span>
                        </p>
                    </div>
                </div>
            </div>

        </article>
        {% endfor %}
    </div>
{% endif %}
{% endif %}

<div class="row">

    {# Show the filters #}
        {% if history|length is not 0 %}

        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
            <div class="btn-group filter text-center" style="padding-bottom: 1em;">
                <button class="active btn btn-sm btn-default" href="#" data-group="all" type="button">All</button>
                <button class="btn btn-sm btn-default" href="#" data-group="1" type="button">Phone In</button>
                <button class="btn btn-sm btn-default" href="#" data-group="2" type="button">Phone Out</button>
                <button class="btn btn-sm btn-default" href="#" data-group="3" type="button">Email</button>
                <button class="btn btn-sm btn-default" href="#" data-group="4" type="button">Rep Visit</button>
                <button class="btn btn-sm btn-default" href="#" data-group="5" type="button">Quote</button>
                <button class="btn btn-sm btn-default" href="#" data-group="15" type="button">ETA</button>
            </div>
        </div>


        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="timeline-centered" id="thetimeline">
                {% for line in history %}
                <article class="timeline-entry" data-groups='["all", "{{ line.type.id }}"]'>

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon bg-{{ line.type.style }}">
                            <i class="fa fa-icon fa-{{ line.type.icon }}"></i>
                        </div>

                        <div class="timeline-label">
                            <div class="timeline-content">
                                <h2>{% if line.user %}{{ line.staff.name }}{% endif %} <span>{{ line.type.name }}</span>
                                    {% if line.contact is not empty %}
                                    <span class="pull-right">{{ line.person.name }}</span>
                                    {% endif %}
                                </h2>
                                <p><strong><a href="{{ url('/quotes/view/' ~ line.job )}}">{{ line.job }}</a> {{ line.reference }}</strong></p>
                                <p>{{ parser.parse(line.details) }}
                                    {% if line.followUpNotes %} <br /> {{ line.followUpNotes }} {% endif %}</p>
                                </div>
                                <div class="timeline-footer">
                                    <p>{{ date('d M Y', strtotime(line.date)) }} {% if line.completed is null %} <i class="text-primary fa fa-icon fa-bell"></i> {{ date('d M Y', strtotime(line.followUpDate)) }} {% endif %}
                                        <span class="pull-right">
                                            <a href="#" data-href="{{ url('followup/delete/' ~ line.id) }}" data-toggle="modal" data-target="#confirm-delete" class="text-danger"><i class="fa fa-times"></i> Delete</a> &nbsp;
                                            <a class="text-info" data-target="#modal-ajax" href='{{ url('followup/edit/' ~ line.id) }}' data-target="#modal-ajax"> <i class="fa fa-pencil"></i> Edit</a>
                                        </span>                            </p>
                                    </div>
                                </div>
                            </div>

                        </article>
                        {% endfor %}


                        <article class="timeline-entry begin">

                            <div class="timeline-entry-inner">

                                <div class="timeline-icon" style="-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);">

                                </div>

                            </div>

                        </article>

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
