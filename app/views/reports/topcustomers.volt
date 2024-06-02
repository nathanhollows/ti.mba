<div class="row">
    {% for n in 1..3 %}
    <div class="col-lg-4">
        <ul class="list-group">
            <li class="list-group-item list-group-item-success">
                <h3></h3>Top Customers This X
            </li>
            {% for i in 1..10 %}
                <li class="list-group-item">{{ i }}</li>
            {% endfor %}
        </ul>
    </div>
    {% endfor %}
</div>
