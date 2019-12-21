{{ content() }}
{{ flashSession.output() }}

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Details</h3>
            </div>
            <div class="panel-body">
                {{ user.name }} <br>
                {{ user.email }} <br>
                {{ user.position }} <br>
                {{ user.directDial }}
            </div>
        </div>

        {% if topDay|length > 0 %}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Sales</h3>
            </div>
            <div class="panel-body">
                Biggest Day		<span class="pull-right" data-toggle="tooltip" data-placement="top" title="{{ date("dS M Y", strtotime(topDay.getFirst().date)) }}">${{ topDay.getFirst().sumatory|number }} </span> <div class="clearfix"></div>
                Biggest Week
                    {% for item in topWeek %}
                    {% set date1 = date("jS M", strtotime(item.year ~ "W" ~ item.week ~ "1")) %}
                    {% set date2 = date("jS M Y", strtotime(item.year ~ "W" ~ item.week ~ "5")) %}
                        <span class="pull-right" data-toggle="tooltip" data-placement="top" title="{{ date1 ~ " - " ~ date2 }}">
                            ${{ item.topValue|number }}<br>
                        </span>
                    {% endfor %}
                <div class="clearfix"></div>
                Biggest Month {% for item in topMonth %}
                    <span class="pull-right" data-toggle="tooltip" data-placement="top" title="{{ date("M Y", strtotime(item.month ~ "/01/" ~ item.year)) }}"> ${{ item.topValue|number }}<br> </span>{% endfor %} <div class="clearfix"></div>
                    {% for item in topYear %}
                    Biggest Year
                        <span class="pull-right" data-toggle="tooltip" data-placement="top" title="Year Starting April {{ item.year }}">
                            ${{ item.topValue|number }}<br>
                        </span>
                    {% endfor %}
                <div class="clearfix"></div>
            </div>
            <canvas id="myChart" width="4" height="1"></canvas>
        </div>
        {% endif %}

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Quotes</h3>
            </div>
            <div class="panel-body">
                Presented this month			
                    <span class="pull-right">{% for i in quotes%}
                        {{ i.count }}
                    {% endfor %}</span>
                <div class="clearfix"></div>
                Won this month				
                    <span class="pull-right">{% for i in wonQuotes%}
                        {{ i.count }}
                    {% endfor %}</span>
            </div>
        </div>

    </div>
    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
        <div role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#home" aria-controls="home" role="tab" data-toggle="tab">Timeline</a>
                </li>
                <li role="presentation">
                    <a href="#quotes" aria-controls="tab" role="tab" data-toggle="tab">Quotes</a>
                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content tab-timeline">
                <div role="tabpanel" class="tab-pane active fade in" id="home">
                    {{ partial('timeline') }}
                </div>
                <div role="tabpanel" class="tab-pane fade" id="quotes">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Quotes</h3>
                        </div>
                        <div class="panel-body">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>
                                            Id
                                        </th>
                                        <th>
                                            Customer
                                        </th>
                                        <th>
                                            Reference
                                        </th>
                                        <th>
                                            Status
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for quote in user.quotes %}
                                    <tr>
                                        <td>
                                            {{ link_to("quotes/view/" ~ quote.quoteId, quote.quoteId) }}
                                        </td>
                                        <td>
                                            {{ quote.customer.customerName }}
                                        </td>
                                        <td>
                                            {{ quote.reference }}
                                        </td>
                                        <td>
                                            <span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
$(document).ready(function() {
    $('[data-toggle="tooltip"]').tooltip()
    var ctx = document.getElementById("myChart");
    var sales = [{% for item in sales %}"{{ date("D jS", strtotime(item.date)) }}",{% endfor %}];
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: sales.reverse(),
            datasets: [{
                label: '$',
                data: [{% for item in sales %}{{ item.sumatory }},{% endfor %}],
                borderWidth: 0
            }]
        },
        options: {
            tooltipFontSize: 10,
            percentageInnerCutout : 70,
            tooltips: {
                cornerRadius: 0,
            },
            scaleShowVerticalLines: false,
            scaleShowLabels: false,
            legend: {
                display: false,
            },
            scales: {
                xAxes: [{
                    display: false
                }],
                yAxes: [{
                    display: false
                }],
            }
        }
    });
});
</script>
