{{ flashSession.output() }}
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
                                <td>Code {{ customer.customerCode }}</td>
                                <td>Name {{ customer.customerName }}
                                <hr>
                                Status <span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span>
                                <hr>
                                Phone {{ customer.customerPhone }}
                                <hr>
                                Fax {{ customer.customerFax }}
                                <hr>
                                Email <a href="mailto:{{ customer.customerEmail }}">{{ customer.customerEmail }}</a>
                                <hr>
                            {% if customer.group is not empty %}
                                Group {{ customer.group.name }}
                                <hr>
                            {% endif %}
                            {% if customer.freightarea is not empty %}
                                Freight Area {{ customer.freightarea.name }}
                                <hr>
                            {% endif %}
                            {% if customer.freightcarrier is not empty %}
                                Carrier {{ customer.freightcarrier.name }}
                                <hr>
                            {% endif %}
                            {% if customer.salesarea is not empty %}
                                Sales Area {{ customer.salesarea.name }}
                                <hr>
                            {% endif %}
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
                </div>
            </div>
                    <div class="panel-body">
                        {% for contact in customer.contacts %}
                            <div class="well">
                                <h4> 
                                    {{ link_to("contacts/view/" ~ contact.id, contact.name) }}
                                </h4>
                                <p>
                                    <h5>
                                        {% if contact.position is numeric %}
                                            {{ contact.job.name }}
                                        {% else %}
                                            {{ contact.position }}
                                        {% endif %}</h5><br>
                                    <i class="fa fa-phone"></i> <a href="tel:{{ contact.directDial }}">{{ contact.directDial }} </a><br>
                                    <i class="fa fa-envelope"></i> <a href="mailto:{{ contact.email }}">{{ contact.email }} </a><br>
                                </p>
                            </div>
                        {% endfor %}
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

<div class="col-xs-12 col-sm-12 col-md-8 col-lg-9 pull-right">

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
                    <th>#</th>
                    <th>Date</th>
                    <th>Reference</th>
                    <th>Rep</th>
                    <th>Contact</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>#</th>
                    <th>Date</th>
                    <th>Reference</th>
                    <th>Rep</th>
                    <th>Contact</th>
                    <th>Status</th>
                </tr>
            </tbody>
        </table>

    </div>
</div>
</div>


</div>

</div>
