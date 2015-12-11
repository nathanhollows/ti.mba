<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">

{% if !(customer.status.id is 1) %}
    <div class="alert alert-{{customer.status.style}}">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <strong>{{ customer.status.name|capitalize }}</strong> This account is marked: {{ customer.status.name }}
    </div>
{% endif %}

    <div role="tabpanel">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#details" aria-controls="details" role="tab" data-toggle="tab">Details</a>
            </li>
            <li role="presentation">
                <a href="#history" aria-controls="history" role="tab" data-toggle="tab">Contact History</a>
            </li>
            <li role="presentation">
                <a href="#personnel" aria-controls="personnel" role="tab" data-toggle="tab">Personnel</a>
            </li>
            <li role="presentation">
                <a href="#status" aria-controls="status" role="tab" data-toggle="tab">Status</a>
            </li>            
            <li role="presentation">
                <a href="#notes" aria-controls="notes" role="tab" data-toggle="tab">Notes</a>
            </li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="details">
            <br />
            <strong>{{ customer.customerCode }}</strong> {{ customer.customerName }} <br />
            <strong>Phone</strong> <a href="tel:{{customer.customerPhone}}">{{ customer.customerPhone }} </a><br />
            <strong>Fax</strong> {{ customer.customerFax }} <br />
            <strong>Email</strong> <a href="mailto:{{ customer.customerEmail }}">{{ customer.customerEmail }}</a> <br />
            <br />

            {% if addresses %}
                <div class="row">
                    {% for address in addresses %}
                        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                            <div class="well">
                                <b> {{ address.type.typeDescription }} </b> 

                                {% if (customer.defaultAddress is address.customerAddressId) %}
                                    <span class="badge">Default</span>
                                {% endif %}

                                <br>
                                {% for key, line in address.address %}
                                    {% if !(line is empty) and !(key is 'id') and !(key is 'customerCode') %}
                                        {{ line }}<br>
                                    {% endif %}
                                {% endfor %}    
                            </div>
                        </div>  
                    {% endfor %}    
                </div>
            {% endif %}

        </div>
        <div role="tabpanel" class="tab-pane" id="history">History</div>
        <div role="tabpanel" class="tab-pane" id="personnel">
            <div class="row">
                {% for contact in customer.contacts %}
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <div class="thumbnail">
                            <div class="caption">
                                <h3> {{ contact.firstName }} {{ contact.lastName }}
                                </h3>
                                <p>
                                    <strong>{{ contact.position }}</strong><br>
                                    <strong>Phone</strong> {{ contact.directDial }}<br>
                                    <strong>Cell Phone</strong> {{ contact.cellPhone }}<br>
                                    <strong>Email</strong> {{ contact.email }}<br>
                                    </p>
                                <p>
                                    {{ link_to("contacts/view/" ~ contact.id, 'View', 'class': 'btn btn-primary') }}
                                </p>
                            </div>
                        </div>
                    </div>
                {% endfor %}
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="status">
            Status
        </div>
        <div role="tabpanel" class="tab-pane" id="notes">Notes</div>
    </div>
</div>

</div>

<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
    <div class="well well-lg">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    </div>
</div>