<button class="btn btn-default" onclick="location.reload()">Refresh</button>
<ul class="list-group">
{% for order in orders %}
    <li class="list-group-item">
        <p>
        <strong>{{ order.orderNumber }}</strong> {{ order.customer.customerName }}
        {% if order.customer.rank < 11 %}<span class="badge badge-pill badge-info">Top 10 Customer</span>{% endif %}
        <button class="btn btn-primary float-right">Complete</button>
        <button class="btn btn-primary mr-1 float-right" type="button" data-toggle="collapse" data-target="#collapse{{ order.orderNumber }}" aria-expanded="false" aria-controls="collapse{{ order.orderNumber }}">View</button>
        </p>

        <div class="" id="{{ order.orderNumber }}">
            <table class="table">
                <thead>
                    <th>Line</th>
                    <th>Size</th>
                    <th>Description</th>
                    <th>Tally</th>
                    <th>Quantity</th>
                </thead>
                <tbody>
                    {% for item in order.items %}
                        <tr>
                            {% if item.grade in ['FREIGHT', 'CREDIT', 'SETUP'] %}
                            <td>{{ loop.index }}</td>
                            <td></td>
                            <td>{{ item.grade }}</td>
                            <td></td>
                            <td>{{ item.ordered }} {{ item.unit }}</td>
                            {% else %}
                            <td>{{ loop.index }}</td>
                            <td>{{ item.width }} x {{ item.thickness }}</td>
                            <td>{{ item.Grade.name }} {{ item.treatment }} {{ item.dryness }} {{ item.Finish.name }}</td>
                            <td>
                                {% if item.tallies %}
                                {% for tally in item.tallies %}
                                {{ tally.pieces }}/{{ number_format(tally.length,1) }}
                                {% endfor %}
                                {% endif %}
                            </td>
                            <td>{{ item.ordered }} {{ item.unit }}</td>
                            {% endif %}
                        </tr>
                    {% endfor %}
                </tbody>
            </table>
            {% if order.description %}
                <strong>Order Notes</strong>
                <p>{{ order.description }}</p>
            {% endif %}
            {% if order.notes %}
                <strong>Despatcher Notes</strong>
                <p>{{ order.notes }}</p>
            {% endif %}
        </div>

    </li>
{% endfor %}
</ul>
