<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Search</h6>
				<h4 class="header-title">Quotes</h4>
			</div>
			<div class="col text-right">
				<a class="btn btn-primary" href="{{ url("quotes/new") }}">New Quote</a>
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

		<div class="dropdown mr-3">
			<button class="btn btn-secondary dropdown-toggle" id="filterlist-user" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				All reps
			</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				{% for user in users %}
				{% if user.quotes|length > 0 %}
				<a class="dropdown-item filter-user" data-user="{{ user.name }}" href="#">{{ user.name }}</a>
				{% endif %}
				{% endfor %}
				<div class="dropdown-divider"></div>
				<a class="dropdown-item filter-user" data-user="" href="#">All Reps</a>
			</div>
		</div>

		<div class="dropdown">
			<button class="btn btn-secondary dropdown-toggle" id="filterlist-status" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Status</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item filter-status" data-status="Cold" href="#">Cold</a>
				<a class="dropdown-item filter-status" data-status="Warm" href="#">Warm</a>
				<a class="dropdown-item filter-status" data-status="Hot" href="#">Hot</a>
				<a class="dropdown-item filter-status" data-status="Dead" href="#">Dead</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item filter-status" data-status="" href="#">All Statuses</a>
			</div>
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
</div>
<script src="{{ url('js/datatables/quotes.js') }}"></script>
<style media="screen">
.dataTables_length {
	width: 202px;
	display: inline-block;
}
.toolbar, .dataTables_info, .dataTables_length {
	float: left;
		display: flex;
}
</style>
