<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
    <div class="panel panel-primary ">
        <div class="panel-heading">
            <h3 class="panel-title"><strong>Customer</strong> Info</h3>
        </div>
        <div class="panel-body">
            <strong>{{ customer.customerCode }}</strong> {{ customer.customerName }} 
            <span class="label label-{{ customer.status.style }}">{{ customer.status.name }}</span> <br />
            <strong>Phone</strong> <a href="tel:{{customer.customerPhone}}">{{ customer.customerPhone }} </a><br />
            <strong>Fax</strong> {{ customer.customerFax }} <br />
            <strong>Email</strong> <a href="mailto:{{ customer.customerEmail }}">{{ customer.customerEmail }}</a> <br />
            <strong>Sales Area</strong> {{ customer.salesArea }}<br />
            <strong>Freight Area</strong> {{ customer.freightarea.name }}<br />
            <strong>Freight Carrier</strong> {{ customer.freightcarrier.name }}<br />
        </div>
    </div>
</div>

<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 pull-right">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Orders <span class="label label-default">4</span></h3>
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
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</div>


<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">Contacts</h3>
        </div>
        <div class="panel-body">
            {% for contact in customer.contacts %}
            <h3> {{ contact.firstName }} {{ contact.lastName }}
            </h3>
            <p>
            <h5>{{ contact.position }}</h5><br>
            <strong>Phone</strong> {{ contact.directDial }}<br>
            <strong>Cell Phone</strong> {{ contact.cellPhone }}<br>
            <strong>Email</strong> {{ contact.email }}<br>
            </p>
            <p>
                {{ link_to("contacts/view/" ~ contact.id, 'View', 'class': 'btn btn-primary') }}
            </p>
            {% endfor %}
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
                    <div class="pull-right"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></div></h3>
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

<div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 pull-right">
    <div class="panel panel-default">
      <div class="panel-heading">
          <h3 class="panel-title">History</h3>
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
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
                <tr>
                    <td>45961</td>
                    <td>DS 564121321</td>
                    <td>{{ date('d-m-Y') }}</td>
                    <td><span class="label label-primary">On track</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</div>

</div>