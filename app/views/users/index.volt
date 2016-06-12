{{ content() }}

<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>Name</th>
			<th>Email</th>
			<th>Phone</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
		{% for user in users %}
			{% set note = "" %}
			{% if user.banned == 1 %}
				{% set class = "danger" %}
				{% set note = "<br> This user is banned" %}
			{% elseif user.suspended == 1 %}
				{% set class = "warning" %}
				{% set note = "<br> This user is suspended" %}
			{% elseif user.active == 0 %}
				{% set class = "info" %}
				{% set note = "<br> This user needs to be activated" %}
			{% endif %}
			<tr class="{{ class }}">
				<td>{{ user.name ~ note }}</td>
				<td>{{ user.email }}</td>
				<td>{{ user.directDial }}</td>
				<td>Edit Delete</td>
			</tr>
			{% set class = "" %}
			{% set note = "" %}
		{% endfor %}
	</tbody>
</table>