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
				<div class="btn-group btn-group-toggle" id="filterlist-status" data-toggle="buttons">
					<label class="filter-user btn btn-sm btn-outline-secondary" data-user="{{ auth.getName() }}">
						<input type="radio" name="options" id="option1" autocomplete="off"> My Quotes
					</label>
					<label class="filter-user btn btn-sm btn-outline-secondary" data-user="">
						<input type="radio" name="options" id="option2" autocomplete="off"> All Quotes
					</label>
				</div>
				<div class="btn-group btn-group-toggle" id="filterlist-status" data-toggle="buttons">
					<label class="filter-status btn btn-sm btn-outline-secondary" data-status="Warm">
						<input type="radio" name="options" id="option1" autocomplete="off"> Active
					</label>
					<label class="filter-status btn btn-sm btn-outline-secondary" data-status="">
						<input type="radio" name="options" id="option2" autocomplete="off"> Active + Dead
					</label>
				</div>
    </div>

    <div>
        <table class="table table-bordered table-striped table-hover dataTable bg-white" data-source="{{ url('quotes/ajax/') }} ">
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
