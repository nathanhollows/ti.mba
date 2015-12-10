<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">

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

            {% for element in customer %}
                {{ element }} <br>
            {% endfor %}
                {{ customer.customerCode }}<br />
                {{ customer.customerName }}
                    <span class="label label-{{ customer.customerstatus.style }}">{{ customer.customerstatus.name }}</span>

        <div role="tabpanel" class="tab-pane" id="history">History</div>
        <div role="tabpanel" class="tab-pane" id="personnel">
        <div class="row">
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="thumbnail">
                    <div class="caption">
                        <h3>Joe Blogs</h3>
                        <p>
                            <strong>Sales Tep</strong><br>
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                            tempor incididunt ut labore et dolore magna aliqua.
                            </p>
                        <p>
                            <a href="#" class="btn btn-primary">View</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="thumbnail">
                    <div class="caption">
                        <h3>Joe Blogs</h3>
                        <p>
                            <strong>Sales Tep</strong><br>
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                            tempor incididunt ut labore et dolore magna aliqua.
                            </p>
                        <p>
                            <a href="#" class="btn btn-primary">View</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="thumbnail">
                    <div class="caption">
                        <h3>Joe Blogs</h3>
                        <p>
                            <strong>Sales Tep</strong><br>
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                            tempor incididunt ut labore et dolore magna aliqua.
                            </p>
                        <p>
                            <a href="#" class="btn btn-primary">View</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="thumbnail">
                    <div class="caption">
                        <h3>Joe Blogs</h3>
                        <p>
                            <strong>Sales Tep</strong><br>
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                            tempor incididunt ut labore et dolore magna aliqua.
                            </p>
                        <p>
                            <a href="#" class="btn btn-primary">View</a>
                        </p>
                    </div>
                </div>
            </div>
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