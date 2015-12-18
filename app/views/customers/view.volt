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
                                <strong class="col-sm-2">Code</strong>
                                <div class="col-sm-10">
                                    {{ customer.customerCode }}
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Name</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerName" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Customer Name">{{ customer.customerName }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Status</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerFax" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.customerStatus }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Phone</strong>
                                <div class="col-sm-10">
                                    <a href="tel:{{ customer.customerPhone }}" id="customerPhone" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.customerPhone }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Fax</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerFax" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.customerFax }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Email</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerEmail" class="generaledit" data-type="email" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.customerEmail }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Group</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerGroup" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.customerGroup }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Freight Area</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerFreightArea" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.freightArea }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Freight Carrier</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerFax" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.freightCarrier }} </a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <strong class="col-sm-2">Sales Area</strong>
                                <div class="col-sm-10">
                                    <a href="#" id="customerFax" class="generaledit" data-type="text" data-pk="1" data-url="/post" data-title="Enter username">{{ customer.salesArea }} </a>
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
                        <i class="fa fa-icon fa-plus pull-right"></i></h3>
                    </div>
                    <div class="panel-body">
                        {% for contact in customer.contacts %}
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="well">
                                <h3> {{ contact.name }}
                                </h3>
                                <p>
                                    <h5>{{ contact.position }}</h5><br>
                                    <strong>Phone</strong> {{ contact.directDial }}<br>
                                    <strong>Cell Phone</strong> {{ contact.cellPhone }}<br>
                                    <strong>Email</strong> {{ contact.email }}<br>
                                </p>
                                <p>
                                    {{ link_to("contacts/view/" ~ contact.id, 'View', 'class': 'btn btn-sm btn-info') }}
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

</div>