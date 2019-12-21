{{ flashSession.output() }}
{{ content() }}
<div class="col-xs-12 col-sm-12 col-md-4 col-lg-3">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Customer</strong> Info
                        <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('customers/edit/' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> Edit</a>
                    </h3>
                </div>
                <ul class="list-group">
                    <li class="list-group-item"><span class="title">Status</span> <span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span></li>
                    <li class="list-group-item"><span class="title">Code</span>{{ customer.customerCode }}</li>
                    <li class="list-group-item"><span class="title">Name</span>{{ customer.customerName }}</li>
                    <li class="list-group-item"><span class="title">Phone</span><a href="tel:{{ customer.phone|stripspace }}" class="tel-link">{{ customer.phone }}</a></li>
                    <li class="list-group-item"><span class="title">Fax</span> {{ customer.fax }}</li>
                    <li class="list-group-item"><span class="title">Email</span> <a href="mailto:{{ customer.email }}">{{ customer.email }}</a></li>
                    <li class="list-group-item">
                        <span class="title">Group</span>
                        {% if customer.group is not empty %}
                        {{ customer.group.name }}
                        {% endif %}
                    </li>
                    <li class="list-group-item"><span class="title">Sales Area</span>
                        {% if customer.salesarea is not empty %}
                        {{ customer.salesarea.name }}
                        {% endif %}
                    </li>
                    <li class="list-group-item"><span class="title">Trip Day</span>{{ customer.tripDay }}</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Begin Address -->
    {% if addresses %}
    <div class="row">
        {% for address in addresses %}
        <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">{{ address.type.typeDescription }}
                        <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('address/edit/' ~ address.id) }}' data-target="#modal-ajax"><i class="fa fa-edit"></i></a>
                        {#<a href="https://maps.google.com/?q={{ address.line1 ~ " " ~ address.city }}" class="pull-right text-info" target="_blank"><i class="fa fa-icon fa-map-marker" class="pull-right"></i> </a>#}
                    </h3>
                </div>
                <div class="panel-body">
                    {% if address.line1 is not empty %} {{ address.line1 }} <br>{% endif %}
                    {% if address.line2 is not empty %} {{ address.line2 }} <br>{% endif %}
                    {% if address.line3 is not empty %} {{ address.line3 }} <br>{% endif %}
                    {% if address.city is not empty %} {{ address.city }} {% endif %} {% if address.zipCode is not empty %} {{ address.zipCode }}{% endif %}
                    {% if address.country is not "New Zealand" %}<br> {{ address.country }} {% endif %}
                </div>
            </div>
        </div>
        {% endfor %}
    </div>
    {% endif %}
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                <a class="text-info" data-target="#modal-ajax" href='{{ url('address/new/' ~ customer.customerCode) }}' data-target="#modal-ajax">
                    Add Address
                    <span class="pull-right"><i class="fa fa-plus"></i></span></a>
                </h3>
            </div>
        </div>
        <!-- End Addresses -->
    </div>

    <div class="col-xs-12 col-sm-12 col-md-8 col-lg-9 pull-right">
        <div role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#home" aria-controls="home" role="tab" data-toggle="tab">Timeline</a>
                </li>
                <li role="presentation">
                    <a href="#contacts" aria-controls="tab" role="tab" data-toggle="tab">Contacts</a>
                </li>
                <li role="presentation">
                    <a href="#quotes" aria-controls="tab" role="tab" data-toggle="tab">Quotes</a>
                </li>
                {% if customer.orders|length > 0 %}
                <li role="presentation">
                    <a href="#orders" aria-controls="tab" role="tab" data-toggle="tab">Orders <span class="badge">{{ customer.orders|length }}</span></a>
                </li>
                {% endif %}
            </ul>

            <!-- Tab panes -->
            <div class="tab-content tab-timeline">
                <div role="tabpanel" class="tab-pane active" id="home">
                    {{ partial('timeline') }}
                </div>
                <div role="tabpanel" class="tab-pane fade" id="contacts">
                        <div class="btn-group pull-right">
                            <button type="button" id="edit-button" class="btn btn-default">
                                <i class="fa fa-icon fa-pencil"></i> Edit List
                            </button>
                            <a class="btn btn-default" data-target="#modal-ajax" href="/contacts/new/{{ customer.customerCode }}" role="button"><i class="fa fa-icon fa-plus"></i> Add Contact</a>
                        </div>
                        <div class ="clearfix"> </div>
                        <ul class="list-group">
                            {% set role = "h" %}
                            {% for contact in contacts %}
                                {% if contact.role is not role %}
                                    </ul>
                                    <h4>{% if contact.job %}{{ contact.job.name }}{% else %}Misc{% endif %}</h4>
                                    <ul class="list-group">
                                    {% set role = contact.role %}
                                {% endif %}
                                <li class="list-group-item">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                                            <span class="xedit-toggle" data-name="name" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Name">
                                                {{ contact.name }}
                                            </span>
                                            <span class="xedit-toggle xedit-hide pull-right" data-name="role" data-type="select" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Role" data-value="{{ contact.role }}" data-source='{{ roles }}'></span>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                                            <a href="tel:{{ contact.directDial|stripspace }}" class="xedit-toggle tel-link" data-name="directDial" data-type="tel" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Direct Dial">{{ contact.directDial }}</a>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                                            <a href="mailto:{{ contact.email }}" class="xedit-toggle" data-name="email" data-type="text" data-pk="{{ contact.id }}" data-url="/contacts/ajaxupdate" data-title="Email">{{ contact.email }}</a>
                                            <a href="#" data-href="/contacts/delete/{{ contact.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete pull-right"><i class="fa fa-times"></i></a>
                                        </div>
                                    </div>
                                </li>
                            {% endfor %}
                        </ul>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="quotes">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th> ID </th>
                                <th> Reference </th>
                                <th> Value </th>
                                <th> Rep </th>
                                <th> Status </th>
                            </tr>
                        </thead>
                        <tbody>
                            {% for quote in customer.quotes %}
                                <tr>
                                    <td> {{ link_to('quotes/view/' ~ quote.quoteId ~ '/', quote.quoteId )}} </td>
                                    <td> {{ quote.reference }} </td>
                                    <td> ${{ quote.value|number }} </td>
                                    <td> {{ quote.rep.name }} </td>
                                    <td> <span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span></td>
                                </tr>
                            {% endfor %}
                        </tbody>
                    </table>
                </div>
                {% if customer.orders|length > 0 %}
                <div role="tabpanel" class="tab-pane fade" id="orders">
                    <div class="row">
                    {% for order in customer.orders %}
                        <div class="col-lg-6">
                            <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Order {{ order.orderNumber }} - {{ order.customerRef }}
                                </h3>
                            </div>
                            <div class="panel-body">
                                <dl class="dl-horizontal">
                                    <dt>Date</dt>
                                    <dd>{{ date('d-m-Y', strtotime(order.date)) }}</dd>
                                    <dt>ETA</dt>
                                    <dd>{% if order.eta %}{{ date('d-m-Y', strtotime(order.eta)) }}{% endif %}</dd>
                                    <dt>Location</dt>
                                    <dd>{% if order.location %}{{ order.whereabouts.name }} {% endif %}</dd>
                                    <dt>Order Notes</dt>
                                    <dd>{{ order.description|escape }}</dd>
                                    <dt>Despatcher Notes</dt>
                                    <dd>{{ order.notes|escape }}</dd>
                                </dl>
                                <ul class="list-group">
                                    {% for item in order.items %}
                                        <li class="list-group-item {% if item.complete is 1 %}complete{% endif %}">
                                            {% if item.grade === "FREIGHT" or item.grade === "CREDIT" or item.grade === "SETUP" %}
                                            <strong>{{ item.itemNo }}.</strong>
                                            {{ item.grade|lower|capitalize }}
                                            <span class="pull-right">${{ item.price }}</span>
                                            {% continue %}
                                            {% endif %}
                                            {% if item.despatch %}
                                                <span class="label label-success pull-right">Scheduled</span>
                                            {% endif %}
                                            {% if item.complete is 1 %}
                                                <span class="label label-info pull-right">Complete</span>
                                            {% endif %}
                                            <strong>{{ item.itemNo }}.</strong>
                                            {{ item.width }} x {{ item.thickness }}
                                            {{ item.grade }}
                                            {{ item.treatment }}
                                            {{ item.dryness }}
                                            {{ item.finish }}
                                            <em>{{ item.notes }}</em><br>
                                            {% if item.complete is 1 %}
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                {% if item.tallies %}
                                                {% for tally in item.tallies %}
                                                {{ tally.pieces }}/{{ number_format(tally.length,1) }}
                                                {% endfor %}
                                                {% endif %}
                                                <code>
                                                    {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
                                                </code>
                                            {% else %}
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                {% if item.tallies %}
                                                {% for tally in item.tallies %}
                                                {{ tally.pieces }}/{{ number_format(tally.length,1) }}
                                                {% endfor %}
                                                {% endif %}
                                                <code>
                                                    {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
                                                </code>
                                            {% endif %}
                                            <span class="pull-right">${{ item.price }}</span>
                                        </li>
                                    {% endfor %}                				</ul>
                            </div>
                        </div>

                        </div>
                    {% endfor %}
                </div>
                </div>
                {% endif %}
            </div>
        </div>
    </div>


</div>

</div>

<script type="text/javascript">
$(document).ready(function() {
    $.fn.editable.defaults.mode = 'inline';
    $('.xedit-toggle').editable('toggleDisabled');
    $('#edit-button').click(function() {
        $('.xedit-toggle').editable('toggleDisabled');
    });
});
</script>
