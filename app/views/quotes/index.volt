{{ flashSession.output() }}
{{ content() }}
<div id="filter-list">
    <div class="btn-group">
        <a class="btn btn-default dropdown-toggle" id="filterlist-user" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">All Reps <span class="caret"></span></a>
        <ul class="dropdown-menu">
            {% for user in users %}
            {% if user.quotes|length > 0 %}
                <li><a href="#" class="filter-user" data-user="{{ user.name }}">{{ user.name }}</a></li>
                {% endif %}
            {% endfor %}
            <li><a href="#" class="filter-user" data-user="">All Reps</a></li>
        </ul>
    </div>
    <div class="btn-group">
        <a class="btn btn-default dropdown-toggle" id="filterlist-status" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Status <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><a href="#" class="filter-status" data-status="Cold">Cold</a></li>
            <li><a href="#" class="filter-status" data-status="Warm">Warm</a></li>
            <li><a href="#" class="filter-status" data-status="Hot">Hot</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#" class="filter-status" data-status="">All Status</a></li>
        </ul>
    </div>
</div>
{#</div>#}
<div class="table-responsive">
    <table class="table table-bordered table-striped table-hover dataTable" data-source="{{ url('quotes/ajax/') }} ">
        <thead>
            <tr>
                <th>#</th>
                <th>Date</th>
                <th>Customer</th>
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
                <th>Customer</th>
                <th>Reference</th>
                <th>Rep</th>
                <th>Contact</th>
                <th>Status</th>
            </tr>
        </tbody>
        <tfoot>
            <th>#</th>
            <th>Date</th>
            <th>Customer</th>
            <th>Reference</th>
            <th>Rep</th>
            <th>Contact</th>
            <th>Status</th>
        </tfoot>
    </table>
</div>
<style media="screen">
.dataTables_length {
    width: 202px;
    display: inline-block;
}
.toolbar, .dataTables_info, .dataTables_length {
    float: left;
}
</style>
