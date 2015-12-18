{{ content() }}

<ul class="pager">
    <li class="pull-right">
        {{ link_to("customers/new", "Create New") }}
    </li>
</ul>

<div class="table-responsive">
	<table class="table table-bordered table-striped table-hover" id="customers">
		<thead>
			<tr>
				<th>Code</th>
				<th>Customer Name</th>
				<th>Phone</th>
				<th class="hidden-xs">Fax</th>
				<th>Status</th>
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
				<th>Status</th>
			</tr>
		</thead>
	</table>
</div>