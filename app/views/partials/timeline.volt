{% if history|length is not 0 %}
            <div class="timeline-centered">

                    {% for line in history %}
                <article class="timeline-entry">

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon bg-{{ line.type.style }}">
                            <i class="fa fa-icon fa-{{ line.type.icon }}"></i>
                        </div>

                        <div class="timeline-label">
                            <h2>{{ line.staff.name }} <span>{{ line.type.name }}</span> 
                            {% if line.contact is not empty %}
                                <span class="pull-right">{{ line.person.name }}</span>
                            {% endif %}
                            </h2>
                            <p>{{ parser.parse(line.details) }}</p>
                            <p>{{ line.date|timeAgo }}
                                <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('followup/edit/' ~ line.id) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> Edit</a>
                            </p>
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
{% else %}

            <div class="timeline-centered">

                <article class="timeline-entry begin">

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon" style="-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);">
                            
                        </div>

                        <div class="timeline-label">
                            <h2>Woops! <span>There doesn't seem to be anything here!</span></h2>
                            <p>You can be the first to
                                <a class="text-info" data-target="#modal-ajax" href='{{ url('followup/?company=' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> add a record!</a>
                            </p>
                        </div>

                    </div>

                </article>


                <article class="timeline-entry begin">

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon">

                        </div>

                    </div>

                </article>

            </div>

{% endif %}