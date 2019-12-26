<div class="header py-3">
    <div class="container">
        <div class="row header-body">
            <div class="col">
                <h6 class="header-pretitle">List</h6>
                <h4 class="header-title">Users</h4>
            </div>
            <div class="col text-right">
                {{ linkTo(['users/new', 'New User', 'class': 'btn btn-primary disabled']) }}
            </div>
            <hr />
        </div>
    </div>
</div>

<div class="container">
	{{ flashSession.output() }}
	{{ content() }}
	<div class="row">
		<div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Name</th>
								<th>Edit</th>
								<th>Delete</th>
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
							{% set note = "<br>" ~ link_to("users/activate/" ~ user.id , "Activate") ~ " this user" %}
							{% endif %}
							<tr class="{{ class }}">
								<td>{{ link_to("profile/view/" ~ user.id, user.name) ~ note }}</td>
								<td>
									{{ link_to("users/edit/" ~ user.id, "Edit") }}
								</td>
								<td>
									<a href="#" data-href="/users/delete/{{ user.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger">Delete</a>
								</td>
							</tr>
							{% set class = "" %}
							{% set note = "" %}
							{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
