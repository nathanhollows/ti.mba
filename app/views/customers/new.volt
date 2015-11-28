<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("customers", "Go Back") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Create customers
    </h1>
</div>

{{ content() }}

{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

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


<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        {{ submit_button('Save', 'class': 'btn btn-default') }}
    </div>
</div>

</form>
