<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Link</th>
					<th>Date</th>
					<th>Complete By</th>
					<th>User</th>
					<th class="col-md-6">Notes</th>
					<th>Complete</th>
				</tr>
			</thead>
			<tbody>
				{% for line in tasks %}
					<tr>
						<td>{{ linkTo(line.controller ~ '/' ~ line.action ~ '/' ~ line.params, line.id)}}</td>
						<td>{{ line.date }}</td>
						<td>{{ line.followUpDate }}</td>
						<td>{{ line.chaseUser.name }}</td>
						<td>{{ line.notes }}</td>
						<td>{{ link_to('tasks/complete/' ~ line.id, 'Mark Complete', 'class': 'btn btn-primary btn-sm') }}</td>
					</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>	
</div>

