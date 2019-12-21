<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Outstanding Orders (<span id="count"></span>)</h3>
    </div>
    <div class="panel-body">
        <input id="list-search" name="search" placeholder="Search by name, order number, sales rep, location ..." type="text" data-list=".list" class="form-control" accesskey="s" autocomplete="off" autofocus="true">
    </div>
    <div class="panel-body scroll">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Order</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody class="list">
                {% for order in orders %}
                <tr data-order="{{ order.orderNumber }}">
                    <td>
                        <a class="show-order" data-order="{{ order.orderNumber }}">{{ order.orderNumber }}</a>
                        <span hidden>{{ order.rep }}</span>
                    </td>
                    {% if order.customerCode is null %}
                    <td></td>
                    {% else %}
                    <td>{% if order.customer %}{{ order.customer.customerName}}{% endif %}<br>
                    {{ order.customerRef }}</td>
                    {% endif %}
                    <td>{{ date("M d", strtotime(order.date)) }} <br>
                    {% if order.eta %}{{ date("M d", strtotime(order.eta)) }} {% endif %}</td>
                    <td>
                        <p>
                            {% if order.scheduled is 1 %}
                            <span class="label label-success">Scheduled</span>
                            {% elseif order.followUp is 1 %}
                            <span class="label label-warning">Follow Up</span>
                            {% endif %}
                        </p>
                        <p>{% if order.location %} <span class="label">{{ order.whereabouts.name }}</span> {% endif %}</p>
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
    </div>
</div>
