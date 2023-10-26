{{ content() }}
{{ flashSession.output() }}
<a href="#sticky-note" class="sticky-icon" data-toggle="modal" data-placement="left">
    <i class="fa fa-icon fa-thumb-tack"></i>
</a>
{% for note in notes %}
    <div class="alert alert-{{ note.type }} alert-dismissible ">
        <a data-href="/dashboard/deletenote/{{ note.id }}" data-toggle="modal" data-target="#confirm-delete"  class="close" aria-label="close">&times;</a>
        <b>{{ note.title|escape }}</b> <em>Expires {{ date("d M", strtotime(note.expires)) }}</em> <br />
        {{ note.note|escape|nl2br }}
    </div>
{% endfor %}
<div class="row">

    <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
        <div class="panel panel-default">
            <div class="panel-heading hidden-xs">
                <h3 class="panel-title">Sales and Chargeout vs Budget Difference</h3>
            </div>
            <div class="panel-body">
                <canvas id="myChart" width="3" height="1"></canvas>
                <div class="row text-center">
                    <hr class="hidden-xs">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <strong>Total Sales</strong> <br>
                        ${{ monthsSales|number }}
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <strong>Charge Out</strong> <br>
                        ${{ kpis.getLast().chargeOut|number }}
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <strong>Sale Count</strong> <br>
                        {% set orderCount = 0 %}
                        {% for item in kpis %}
                        {% set orderCount = orderCount + item.ordersSent %}
                        {% endfor %}
                        {{ orderCount|number }}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
        <div class="panel panel-info">
            {% set dailybudget = budget.budget/budget.days %}
            <div class="panel-heading">
                <h3 class="panel-title"><strong>Daily Sales
                    <span class="pull-right">Goal: ${{ dailybudget|number }}</strong></span>
                </h3>
            </div>
            <ul class="list-group">
                {% for item in daySalesByAgent %}
                <li class="list-group-item">
                    {% for user in users %}
                    {% if user.id == item.rep %}
                    {{ user.name }}
                    {% break %}
                    {% endif %}
                    {% endfor %}
                    <span class="pull-right"> ${{ item.sumatory|number }}</span>
                </li>
                {% endfor %}
                <li class="list-group-item">
                    <strong>Total</strong>
                    <span class="pull-right"> <strong>${{ daySales|number }} </strong></span>
                </li>
            </ul>
            {% if daySales > dailybudget %}
                {% set percent = 100 %}
                {% set label = ((daySales/dailybudget*100)|number) ~ '%' %}
            {% else %}
                {% set percent = (daySales/dailybudget*100)|number %}
                {% set label = percent ~ '%' %}
            {% endif %}
            <div class="progress">
              <div class="progress-bar" role="progressbar" aria-valuenow="{{ percent }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ percent }}%;">
                  {{ label }}
                <span class="sr-only"></span>
              </div>
            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title"><strong>Monthly Sales
                    <span class="pull-right">Goal ${{ budget.budget|number }}</strong></span>
                </h3>
            </div>
            <ul class="list-group">
                {% for item in agentSales %}
                <li class="list-group-item">
                    <span>
                        {% for user in users %}
                        {% if user.id == item.rep %}
                        {{ link_to('profile/view/' ~ user.id ~ '/', user.name, 'class': 'text-primary') }}
                        {% break %}
                        {% endif %}
                        {% endfor %}
                    </span>
                    <span class="pull-right"> ${{ item.sumatory|number }}</span>
                </li>
                {% endfor %}
                <li class="list-group-item">
                    <strong>Total</strong>
                    <span class="pull-right"> <strong> ${{ monthsSales|number }} </strong></span>
                </li>
            </ul>
            {% set progress = (monthsSales/budget.budget*100)|round %}
            {% if progress > 100 %}
                {% set value = 100 %}
                {% set label = progress %}
            {% else %}
                {% set value = progress %}
                {% set label = progress %}
            {% endif %}
            <div class="progress">
              <div class="progress-bar" role="progressbar" aria-valuenow="{{ value }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ value }}%;">
                  {{ label }}%
                <span class="sr-only"></span>
              </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
        <div class="row">
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        <h3 class="panel-title">Quotes Presented (this month)</h3>
                    </div>
                    <div class="panel-body">
                        {{ quotes.presented()['count'] }} (${{ quotes.presented()['value']|number }})
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        <h3 class="panel-title">Quotes Won (this month)</h3>
                    </div>
                    <div class="panel-body">
                        {{ quoteCount }} (${{ quoteSum|number }})
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Oldest Tasks</h3>
          </div>
          <div class="panel-body">
                <ul class="list-group">
                    {% for task in tasks %}
                        {% if loop.index is 6 %}
                            {% break %}
                        {% endif %}
                        {% if task.job is not null %}
                            {% set url = '/quotes/view/' ~ task.job ~ '/' %}
                        {% else %}
                            {% set url = '/customers/view/' ~ task.customerCode ~ '/' %}
                        {% endif %}
                        <a href="{{ url }}"><li class="list-group-item">{{ task.reference }} <br /> {{ task.company.name }}</li></a>
                    {% endfor %}
                </ul>
          </div>
        </div>
    </div>
</div>
<a href="#sticky-note" class="sticky-icon" data-toggle="modal" data-placement="left">
    <i class="fa fa-icon fa-thumb-tack"></i>
</a>
<div class="modal fade" id="sticky-note" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="">Pin a Note</h4>
            </div>
            <form action="{{ url("dashboard/createsticky") }}" method="post">
                <div class="modal-body">
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" value="" class="form-control">
                        <label for="note">Note</label>
                        <textarea name="note" id="note" rows="4" cols="40" class="form-control"></textarea>
                        <label for="expires">Expires</label>
                        <input type="date" name="expires" id="expires" value="{{ date("Y-m-d") }}" class="form-control">
                        <label for="type">Colour</label>
                        <select class="form-control" name="type" id="type">
                            <option value="info">Blue (Info)</option>
                            <option value="success">Green (Success)</option>
                            <option value="danger">Red (Danger)</option>
                            <option value="warning">Yellow (Warning)</option>
                        </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [
                {% for item in sales %}
                "{{ date("D jS", strtotime(item.date)) }}",
                {% endfor %}
            ],
            datasets: [{
                label: 'Budget',
                backgroundColor: "rgba(0,0,0,0.4)",
                borderColor: "rgba(0,0,0,1)",
                pointBorderColor: '#fff',
                pointRadius: 0,
                pointBorderWidth: 0,
                pointBackgroundColor: "rgba(0,0,0,1)",
                pointHoverBorderColor: "#fff",
                data: [
                    {% for item in sales %}0,{% endfor %}
                ]
            },{
                label: 'Sales $',
                backgroundColor: "rgba(244, 67, 54, 0.3)",
                borderColor: "#F44336",
                pointRadius: 2,
                pointBackgroundColor: "rgb(218, 68, 83)",
                pointHoverBorderColor: "#fff",
                data: [
                    {% set base = (budget.budget / budget.days)|round %}
                    {% for item in sales %}
                    {% if loop.first %}
                    {% set difference = 0 %}
                    {% endif %}
                    {% set difference = difference + item.sumatory - base %}
                    {{ difference }},
                    {% endfor %}
                ]
            },{
                label: 'Chargeout',
                backgroundColor: "rgba(3, 169, 244, 0.3)",
                borderColor: "#03A9F4",
                pointRadius: 2,
                pointBackgroundColor: "rgb(59, 175, 218)",
                pointHoverBorderColor: "#fff",
                data: [
                    {% for item in kpis %}
                    {{ item.chargeOut - (base * loop.index) }},
                    {% endfor %}
                ]
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    gridLines: {
                        display: false
                    }
                }]
            }
        }
    });
});
</script>
<style media="screen">
a.sticky-icon {
    display: block;
    position: fixed;
    background: #E9573F;
    color: white;
    font-size: 1.7em;
    border-radius: 100%;
    height: 2em;
    width: 2em;
    text-align: center;
    bottom: 0;
    right: 0;
    z-index: 2;
    margin: 0.5em;
    box-shadow: 3px 3px 12px -3px black;
    transition: all 0.3s;
}
a.sticky-icon:hover {
    background: #FC6E51;
}
i.fa.fa-icon.fa-thumb-tack {
    vertical-align: middle;
    margin-top: 0.5em;
    transform: rotate(45deg);
    transition: transform 0.3s;
}
a.sticky-icon:hover i.fa.fa-icon.fa-thumb-tack {
    transform: rotate(0);
}
</style>
