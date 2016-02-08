<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-primary ">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Customer</strong> Info
                        <a href="#" id="enable" class="pull-right"><i class="fa fa-pencil"></i></a></h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Code</strong>
                                <div class="col-xs-9">
                                    {{ customer.customerCode }} <span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Name</strong>
                                <div class="col-xs-9">
                                    <a href="#" id="customerName" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Customer Name">{{ customer.customerName }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Status</strong>
                                <div class="col-xs-9">
                                    <a href="#" id="customerStatus" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{{ customer.status.name }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Phone</strong>
                                <div class="col-xs-9">
                                    <a href="tel:{{ customer.customerPhone }}" id="customerPhone" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{{ customer.customerPhone }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Fax</strong>
                                <div class="col-xs-9">
                                    <a href="#" id="customerFax" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{{ customer.customerFax }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Email</strong>
                                <div class="col-xs-9">
                                    <a href="mailto:{{ customer.customerEmail }}" id="customerEmail" class="generaledit" data-type="email" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{{ customer.customerEmail }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Group</strong>
                                <div class="col-xs-9">
                                    <a href="{% if customer.customergroup.headOffice %}{{ url('customers/view/' ~ customer.customergroup.headOffice)}}{% else %}#{% endif %}" id="customerGroup" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{% if customer.customergroup %}{{ customer.customergroup.name }}{% endif %} 
                                        {% if customer.customergroup.headOffice %} <span class="label label-info">Head Office</span> {% endif %}</a>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <strong class="col-xs-3 text-right">Freight Area</strong>
                                    <div class="col-xs-9">
                                        <a href="#" id="freightArea" class="generaledit" data-type="select" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{% if customer.freightarea %}{{ customer.freightarea.name }}{% endif %} </a>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <strong class="col-xs-3 text-right">Freight Carrier</strong>
                                    <div class="col-xs-9">
                                        <a href="#" id="freightCarrier" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{% if customer.freightcarrier %}{{ customer.freightcarrier.name }}{% endif  %} </a>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group">
                                    <strong class="col-xs-3 text-right">Sales Area</strong>
                                    <div class="col-xs-9">
                                        <a href="#" id="salesArea" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{% if customer.salesarea %}{{ customer.salesarea.name }}{% endif %} </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>            
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Contacts
                                <a class="pull-right" data-toggle="modal" href='{{ url('contacts/new') }}' data-target="#modal-ajax">Add <i class="fa fa-icon fa-plus"></i></a></h3>
                            </div>
                            <div class="panel-body">
                                {% for contact in customer.contacts %}
                                <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
                                    <div class="well">
                                        <h3> {{ contact.name }}
                                        </h3>
                                        <p>
                                            <h5>{{ contact.position }}</h5><br>
                                            <i class="fa fa-phone"></i> <a href="tel:{{ contact.directDial }}">{{ contact.directDial }} </a><br>
                                            <i class="fa fa-mobile"></i> <a href="tel:{{ contact.cellPhone }}">{{ contact.cellPhone }} </a><br>
                                            <i class="fa fa-envelope"></i> <a href="mailto:{{ contact.email }}">{{ contact.email }} </a><br>
                                        </p>
                                    </div>
                                </div>
                                {% endfor %}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 pull-right">
            <div class="timeline-centered">

                    {% for line in history %}
                <article class="timeline-entry">

                    <div class="timeline-entry-inner">
                        <time class="timeline-time"><span>{{ line.date }}</span> <span>Today</span></time>

                        <div class="timeline-icon bg-{% if line.completed == 1%}success{% else %}danger{% endif %}">
                            <i class="fa fa-icon fa-{{ line.type.icon }}"></i>
                        </div>

                        <div class="timeline-label">
                            <h2>{{ line.staff.name }} <span>{{ line.type.name }}</span></h2>
                            <p>{{ line.details }}</p>
                        </div>
                    </div>

                </article>
                    {% endfor %}


                <article class="timeline-entry begin">

                    <div class="timeline-entry-inner">

                        <div class="timeline-icon" style="-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);">
                            <i class="entypo-flight"></i>
                        </div>

                    </div>

                </article>

            </div>


                <div class="panel panel-default">
                  <div class="panel-heading">
                    <h3 class="panel-title">Quotes
                        <a class="pull-right" data-toggle="modal" href='{{ url('quotes/new/' ~ customer.customerCode) }}' data-target="#modal-ajax">Add <i class="fa fa-icon fa-plus"></i></a></h3>
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Cust Ref</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% for quote in quotes %}
                            <tr>
                                <td>{{ quote.id }}</td>
                                <td>{{ quote.customerRef }}</td>
                                <td>{{ quote.date }}</td>
                                <td><span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.name }}</span></td>
                            </tr>
                            {% endfor %}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>



        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 pull-right">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title"><strong>Customer</strong> Addresses <span class="label label-primary">{{ addresses|length }}</span></h3>
            </div>
            <div class="panel-body">
                {% if addresses %}
                {% for address in addresses %}
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                    <div class="panel panel-default">
                      <div class="panel-heading">
                        <h3 class="panel-title">{{ address.type.typeDescription }}
                            <div class="pull-right"><i class="fa fa-icon fa-edit"></i></div></h3>
                        </div>
                        <div class="panel-body">
                            {% for key, line in address.address %}
                            {% if !(line is empty) and !(key is 'id') and !(key is 'customerCode') %}
                            {{ line }}<br>
                            {% endif %}
                            {% endfor %}
                        </div>
                    </div>    
                </div>
                {% endfor %}    
                {% endif %}
            </div>
        </div>

    </div>

</div>

</div>

<!-- AJAX modal for misc forms -->
<div class="modal fade" id="modal-ajax">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>