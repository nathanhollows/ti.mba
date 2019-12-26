<div class="header py-3">
    <div class="container">
        <div class="row header-body">
            <div class="col">
                <h6 class="header-pretitle">Search</h6>
                <h4 class="header-title">Quotes</h4>
            </div>
            <div class="col text-right">
                <button type="button" class="btn btn-primary">New Quote</button>
            </div>
            <hr />
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col">
            {{ flashSession.output() }}
            {{ content() }}
        </div>
    </div>
</div>

<div class="container-fluid py-2 border bg-white">
    <div id="filter-list">
        <div class="btn-group" role="group" aria-label="Filter My Quotes" id="filterlist-user">
            <button type="button" class="btn btn-sm btn-secondary filter-user" data-user="Regan">My Quotes</button>
            <button type="button" class="btn btn-sm btn-secondary filter-user" data-user="">All Quotes</button>
        </div>
        <div class="btn-group" role="group" aria-label="Filter out dead quotes" id="filterlist-status">
            <button type="button" class="btn btn-sm btn-secondary filter-status" data-status="Dead">Active</button>
            <button type="button" class="btn btn-sm btn-secondary filter-status" data-status="">Dead</button>
        </div>

    </div>

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
    <script src="{{ url('js/datatables/quotes.js') }}"></script>
    <style media="screen">
.dataTables_length {
    width: 202px;
    display: inline-block;
}
.toolbar, .dataTables_info, .dataTables_length {
    float: left;
}
    </style>
