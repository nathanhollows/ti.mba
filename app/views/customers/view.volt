<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-primary ">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Customer</strong> Info
                        <a href="#" id="enable" class="pull-right"><i class="fa fa-pencil"></i> Edit</a></h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-xs-3 text-right">Code</strong>
                                <div class="col-xs-9">
                                    {{ customer.customerCode }} 
                                    {% if customer.status.name is defined %}
                                    <span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span>
                                    {% endif %}
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
                                    {% if customer.status.name is defined %}<a href="#" id="customerStatus" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{{ customer.status.name }} </a>{% endif %}
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
                                    {% if customer.customergroup.headOffice is defined %}<a href="{% if customer.customergroup.headOffice %}{{ url('customers/view/' ~ customer.customergroup.headOffice)}}{% else %}#{% endif %}" id="customerGroup" class="generaledit" data-type="text" data-pk="{{ customer.customerCode }}" data-url="{{ url('customers/update') }}" data-title="Enter username">{% if customer.customergroup %}{{ customer.customergroup.name }}{% endif %} 
                                    {% if customer.customergroup.headOffice %} <span class="label label-info">Head Office</span> {% endif %}</a>
                                    {% endif %}
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
                            <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('contacts/new/' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-plus"></i> Add</a>
                        </div>
                        <div class="panel-body">
                            {% for contact in customer.contacts %}
                            <div class="col-xs-12 col-sm-6 col-md-12 col-lg-12">
                                <div class="well">
                                    <h3> 
                                        {{ link_to("contacts/view/" ~ contact.id, contact.name) }}
                                    </h3>
                                    <p>
                                        <h5>{{ contact.position }}</h5><br>
                                        <i class="fa fa-phone"></i> <a href="tel:{{ contact.directDial }}">{{ contact.directDial }} </a><br>
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

            {{ partial('timeline') }}

            <div class="panel panel-default">
              <div class="panel-heading">
                <h3 class="panel-title">Quotes
                    <a class="pull-right" data-toggle="modal" href='{{ url('quotes/new/?company=' ~ customer.customerCode) }}' data-target="#modal-ajax">Add <i class="fa fa-icon fa-plus"></i></a></h3>
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
                            <td>{{ link_to("quotes/edit/" ~ quote.id, quote.id) }}</td>
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