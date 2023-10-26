{{ content() }}
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel panel-default">
               <div class="panel-heading">
                <h3 class="panel-title">Orders for {{ customer.name }}</h3>
            </div>
            <div class="panel-body">
                <input id="list-search" name="search" placeholder="Search by name, order number, sales rep, location ..." type="text" data-list=".list" class="form-control" accesskey="s" autocomplete="off" autofocus="true">
            </div>
            <div class="panel-body scroll">
                <table class="table">
                    <thead>
                        <th>Order</th>
                        <th>Reference</th>
                        <th>Date In</th>
                        <th>Status</th>
                    </thead>
                    <tbody class="list">
                        {% for order in customer.orders75 %}
                        <tr>
                            <td><a class="show-order" data-order="{{ order.orderNumber }}">{{ order.orderNumber }}</a></td>
                            <td>{{ order.customerRef }}</td>
                            {% if date("Y", strtotime(order.date)) == date("Y") %}
                                <td>{{ date("d M", strtotime(order.date)) }}</td>
                            {% else %}
                                <td>{{ date("d M 'y", strtotime(order.date)) }}</td>
                            {% endif %}
                            <td>
                                {% if order.complete %}
                                    <div class="label">Complete</div>
                                {% else %}
                                    <div class="label label-success">Active</div>
                                {% endif %}
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
