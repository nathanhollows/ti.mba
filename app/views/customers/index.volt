{{ flashSession.output() }}
{{ content() }}
</div>
<div class="table-responsive">
	<table class="table table-bordered table-striped table-hover dataTable" data-source="{{ url('customers/index') }}">
		<thead>
			<tr>
				<th>Code</th>
				<th>Customer Name</th>
				<th>Phone</th>
				<th class="hidden-xs">Fax</th>
				<th class="hidden-xs">Status</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<thead>
			<tr>
				<th>Code</th>
				<th>Customer Name</th>
				<th>Phone</th>
				<th class="hidden-xs">Fax</th>
				<th class="hidden-xs">Status</th>
			</tr>
		</thead>
	</table>
</div>
