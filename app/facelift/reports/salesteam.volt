<div class="container">
    <div class="row">
{{ content() }}
        <div class="col col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Sales</h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        {% for item in sales %}
                        <li class="list-group-item">
                            {{ item.rep }}
                            <strong class="pull-right">${{ item.sum|number }} <span class="badge badge-primary">{{ item.count }}</span></strong>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
        </div>
        <div class="col col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Quotes Presented</h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        {% for item in presented %}
                        <li class="list-group-item">
                            {{ item.user }}
                            <strong class="pull-right">${{ item.sum|number }} <span class="badge badge-primary">{{ item.count }}</span></strong>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
        </div>
        <div class="col col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Quotes Won</h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                        {% for item in quotesWon %}
                        <li class="list-group-item">
                            {{ item.rep }}
                            <strong class="pull-right">${{ item.sum|number }} <span class="badge badge-primary">{{ item.count }}</span></strong>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>