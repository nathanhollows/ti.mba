{% if history|length is not 0 %}
            <div class="timeline-centered">

                    {% for line in history %}
                <article class="timeline-entry">

                    <div class="timeline-entry-inner">
                        <time class="timeline-time"><span>{{ line.date }}</span> <span>Today</span></time>

                        <div class="timeline-icon bg-{% if line.completed == 1%}success{% else %}danger{% endif %}">
                            <i class="fa fa-icon fa-{{ line.type.icon }}"></i>
                        </div>

                        <div class="timeline-label">
                            <h2>{{ line.staff.name }} <span>{{ line.type.name }}</span></h2>
                            <p>{{ line.details }}</p>
                        </div>
                    </div>

                </article>
                    {% endfor %}


                <article class="timeline-entry begin">

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon" style="-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);">
                            <i class="entypo-flight"></i>
                        </div>

                    </div>

                </article>

            </div>
{% endif %}