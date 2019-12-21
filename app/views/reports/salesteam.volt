{{ content() }}

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 ">
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
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 ">
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
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 ">
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
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 ">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Follow Ups</h3>
            </div>
            <div class="panel-body">
                <ul class="list-group">
                  <li class="list-group-item">
                      Dave
                      <strong class="pull-right">$150,200</strong>
                  </li>
                  <li class="list-group-item">
                      Paul
                      <strong class="pull-right">$140,200</strong>
                  </li>
                  <li class="list-group-item">
                      Brad
                      <strong class="pull-right">$12 :(</strong>
                  </li>
                </ul>
            </div>
        </div>
    </div>
</div>
