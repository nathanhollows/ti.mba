{{ content() }}

<div class="col-xs-12 col-sm-12 col-md-4 col-lg-3">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-primary ">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>Customer</strong> Info
                        <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('customers/edit/' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> Edit</a>
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="table table-responsive table-condensed">
                        <tbody>
                            <tr>
                                <td>Code</td>
                                <td>{{ customer.customerCode }}</td>
                            </tr>
                            <tr>
                                <td>Name</td>
                                <td>{{ customer.customerName }}</td>
                            </tr>
                            <tr>
                                <td>Status</td>
                                <td><span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span></td>
                            </tr>
                            <tr>
                                <td>Phone</td>
                                <td>{{ customer.customerPhone }}</td>
                            </tr>
                            <tr>
                                <td>Fax</td>
                                <td>{{ customer.customerFax }}</td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td><a href="mailto:{{ customer.customerEmail }}">{{ customer.customerEmail }}</a></td>
                            </tr>
                            {% if customer.group is not empty %}
                            <tr>
                                <td>Group</td>
                                <td>{{ customer.group.name }}</td>
                            </tr>
                            {% endif %}
                            {% if customer.freightarea is not empty %}
                            <tr>
                                <td>Freight Area</td>
                                <td>{{ customer.freightarea.name }}</td>
                            </tr>
                            {% endif %}
                            {% if customer.freightcarrier is not empty %}
                            <tr>
                                <td>Carrier</td>
                                <td>{{ customer.freightcarrier.name }}</td>
                            </tr>
                            {% endif %}
                            {% if customer.salesarea is not empty %}
                            <tr>
                                <td>Sales Area</td>
                                <td>{{ customer.salesarea.name }}</td>
                            </tr>
                            {% endif %}
                        </tbody>
                    </table>
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
                            <div class="well">
                                <h4> 
                                    {{ link_to("contacts/view/" ~ contact.id, contact.name) }}
                                </h4>
                                <p>
                                    <h5>{{ contact.position }}</h5><br>
                                    <i class="fa fa-phone"></i> <a href="tel:{{ contact.directDial }}">{{ contact.directDial }} </a><br>
                                    <i class="fa fa-envelope"></i> <a href="mailto:{{ contact.email }}">{{ contact.email }} </a><br>
                                </p>
                            </div>
                        {% endfor %}
                    </div>
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
    <!-- End Addresses -->
</div>

<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 pull-right">

    {{ partial('timeline') }}

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Quotes
            <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('quotes/new/?company=' ~ customer.customerCode) }}' data-target="#modal-ajax"><i class="fa fa-plus"></i> Add</a>
        </h3>
    </div>
    <div class="panel-body">
        <table class="table table-bordered table-striped table-hover dataTable" data-source="{{ url('quotes/ajax/' ~ customer.customerCode) }} ">
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


</div>

</div>