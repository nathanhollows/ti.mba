{% set questions = ['I would go out of my way to recommend ATS Timber', 'I would recommend ATS Timber', 'I would not recommend ATS Timber'] %}
<div class="row">
    <div class="col-xs-12 col-xs-12 col-sm-6 col-lg-6">
        <div class="well well-sm">
            <table class="table">
                <thead>
                    <tr>
                        <th>
                            Name
                        </th>
                        <th>
                            Rating
                        </th>
                        <th>
                            Results
                        </th>
                    </tr>
                </thead>
                <tbody>
                    {% for i in results %}
                    <tr>
                        <td>
                            {{ link_to('contacts/view/'~i.person.id, i.person.name ) }}
                            <em>
                                {{ date('M dS', strtotime( i.timestamp )) }}
                                {{ link_to('customers/view/'~i.company.customerCode, i.company.name, 'class': 'text-primary') }}
                            </em>
                            <br />
                            {% if i.feedback %}
                            <blockquote>
                                {{ i.feedback }}
                            </blockquote>
                            {% endif %}
                        </td>
                        <td>
                            {{ i.result8 }}/5
                        </td>
                        <td>
                            <span class="inlinebar">
                            {{ i.result1 }},
                            {{ i.result2 }},
                            {{ i.result3 }},
                            {{ i.result4 }},
                            {{ i.result5 }},
                            {{ i.result6 }},
                            {{ i.result7 }},
                            {{ i.result8 }}
                        </span>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-xs-12 col-xs-12 col-sm-6 col-lg-6">
        <div class="well well-sm">
            <h5>Would you recommend us?</h5>
            {% for i in recommend %}
                <strong>{{ i.result }}</strong> said
                {{ questions[loop.index0] }}
                <br />
            {% endfor %}

                <h5>Quality</h5>
                {% for i in count1 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Delivery</h5>
                {% for i in count2 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Quote Response</h5>
                {% for i in count3 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Phone Performance</h5>
                {% for i in count4 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Product Range</h5>
                {% for i in count5 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Resources</h5>
                {% for i in count6 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Problem Solving</h5>
                {% for i in count7 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}
                <h5>Overall</h5>
                {% for i in count8 %}
                <strong>
                    {{ i.field }}
                </strong>
                was rated
                <strong>
                    {{ i.result }}
                </strong>
                times
                <br>
                {% endfor %}

            </p>
        </div>
    </div>
</div>
<script type="text/javascript">
$(function() {
    $('.inlinebar').sparkline('html', {type: 'bar', barColor: '#37BC9B', chartRangeMin: 0, barWidth: '7px',tooltipValueLookups: {
        names: {
            0: 'Quality',
            1: 'Delivery',
            2: 'Quote Response',
            3: 'Phone Performance',
            4: 'Product Range',
            5: 'Resources',
            6: 'Problem Solving',
            7: 'Overall'
            // Add more here
        }
    },
    tooltipFormat: '<span style="color: {{'{{'}}color}}">&#9679;</span> {{'{{'}}offset:names}} - {{'{{'}}value}}'
} );
    $('.results').sparkline('html', {type: 'bar', barColor: '#37BC9B', chartRangeMin: 0, barWidth: '7px',tooltipValueLookups: {
        names: {
            0: 'Quality',
            1: 'Delivery',
            2: 'Quote Response',
            3: 'Phone Performance',
            4: 'Product Range',
            // Add more here
        }
    },
    tooltipFormat: '<span style="color: {{'{{'}}color}}">&#9679;</span> {{'{{'}}offset:names}} - {{'{{'}}value}}'
} );
});
</script>
