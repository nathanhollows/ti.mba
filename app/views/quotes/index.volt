{{ flashSession.output() }}
{{ content() }}
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
	</table>
</div>