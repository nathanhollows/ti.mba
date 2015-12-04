<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">

    <div role="tabpanel">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#details" aria-controls="details" role="tab" data-toggle="tab">Details</a>
            </li>
            <li role="presentation">
                <a href="#addresses" aria-controls="addresses" role="tab" data-toggle="tab">Addresses</a>
            </li>
            <li role="presentation">
                <a href="#freight" aria-controls="freight" role="tab" data-toggle="tab">Freight</a>
            </li>
            <li role="presentation">
                <a href="#groups" aria-controls="groups" role="tab" data-toggle="tab">Grouping</a>
            </li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="details">
                {{ form("customers/save", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

                <div class="form-group">
                    <label for="fieldCustomercode" class="col-sm-2 control-label">CustomerCode</label>
                    <div class="col-sm-10">
                        {{ text_field("customerCode", "size" : 30, "class" : "form-control", "id" : "fieldCustomercode") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomername" class="col-sm-2 control-label">CustomerName</label>
                    <div class="col-sm-10">
                        {{ text_field("customerName", "size" : 30, "class" : "form-control", "id" : "fieldCustomername") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomerphone" class="col-sm-2 control-label">CustomerPhone</label>
                    <div class="col-sm-10">
                        {{ text_field("customerPhone", "size" : 30, "class" : "form-control", "id" : "fieldCustomerphone") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomerfax" class="col-sm-2 control-label">CustomerFax</label>
                    <div class="col-sm-10">
                        {{ text_field("customerFax", "size" : 30, "class" : "form-control", "id" : "fieldCustomerfax") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomeremail" class="col-sm-2 control-label">CustomerEmail</label>
                    <div class="col-sm-10">
                        {{ text_field("customerEmail", "size" : 30, "class" : "form-control", "id" : "fieldCustomeremail") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldFreightarea" class="col-sm-2 control-label">FreightArea</label>
                    <div class="col-sm-10">
                        {{ text_field("freightArea", "type" : "numeric", "class" : "form-control", "id" : "fieldFreightarea") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldFreightcarrier" class="col-sm-2 control-label">FreightCarrier</label>
                    <div class="col-sm-10">
                        {{ text_field("freightCarrier", "type" : "numeric", "class" : "form-control", "id" : "fieldFreightcarrier") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldSalesarea" class="col-sm-2 control-label">SalesArea</label>
                    <div class="col-sm-10">
                        {{ text_field("salesArea", "type" : "numeric", "class" : "form-control", "id" : "fieldSalesarea") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomerstatus" class="col-sm-2 control-label">CustomerStatus</label>
                    <div class="col-sm-10">
                        {{ text_field("customerStatus", "type" : "numeric", "class" : "form-control", "id" : "fieldCustomerstatus") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldDefaultaddress" class="col-sm-2 control-label">DefaultAddress</label>
                    <div class="col-sm-10">
                        {{ text_field("defaultAddress", "type" : "numeric", "class" : "form-control", "id" : "fieldDefaultaddress") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldDefaultcontact" class="col-sm-2 control-label">DefaultContact</label>
                    <div class="col-sm-10">
                        {{ text_field("defaultContact", "type" : "numeric", "class" : "form-control", "id" : "fieldDefaultcontact") }}
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldCustomergroup" class="col-sm-2 control-label">CustomerGroup</label>
                    <div class="col-sm-10">
                        {{ text_field("customerGroup", "type" : "numeric", "class" : "form-control", "id" : "fieldCustomergroup") }}
                    </div>
                </div>


                {{ hidden_field("id") }}

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        {{ submit_button('Send', 'class': 'btn btn-default') }}
                    </div>
                </div>

            </form>
        </div>
        <div role="tabpanel" class="tab-pane" id="addresses">Addresses</div>
        <div role="tabpanel" class="tab-pane" id="freight">Freight</div>
        <div role="tabpanel" class="tab-pane" id="groups">Grouping</div>
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