<form action="/users/update" method="POST" role="form">
	<div class="header py-3">
		<div class="container">
			<div class="row header-body">
				<div class="col">
					<h6 class="header-pretitle">Editing User</h6>
					<h4 class="header-title">{{ user.name }}</h4>
				</div>
				<div class="col-3 text-right">
				<button type="submit" class="btn btn-primary">Save</button>
				</div>
				<hr class="w-100"/>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-12 col-md-4 offset-md-4">
				
				{{ content() }}
				{{ flashSession.output() }}
				
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">Personal Details</h5>
					</div>
					<div class="panel-body">
						<div class="form-group">
							{{ hidden_field('id', 'value': user.id) }}
							<label for="name">Name</label>
							{{ form.render('name') }}
						</div>
						<div class="form-group">
							<label for="email">Email</label>
							{{ form.render('email') }}
						</div>
						<div class="form-group">
							<label for="position">Position</label>
							{{ form.render('position') }}
						</div>
						<div class="form-group">
							<label for="directDial">Phone</label>
							{{ form.render('directDial') }}
						</div>
					</div>
				</div>
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">
							Groups
						</h5>
					</div>
					<div class="panel-body">
						<ul class="list-group">
							<li class="list-group-item">
								<label for="developer">
									<input type="checkbox" name="developer" id="developer" {% if user.developer is 1 %}checked="checked"{% endif %}>
									Developer
								</label>
								<br />
								<em>Set user as a CRM developer. This turns off error supresssion and removes the user from lists.</em>
							</li>
							<li class="list-group-item">
								<label for="admin">
									<input type="checkbox" name="admin" id="admin" {% if user.administrator is 1 %}checked="checked"{% endif %}>
									Administrator
								</label>
								<br />
								<em>Allow user to view and change settings</em>
							</li>
							<li class="list-group-item">
								<label for="suspended">
									<input type="checkbox" name="suspended" id="suspended" {% if user.suspended is 1 %}checked="checked"{% endif %}>
									Suspended
								</label>
								<br />
								<em>Block a user from logging in</em>
							</li>
						</ul>
					</div>
				</div>
				<br>
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">Reset Password</h9>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="newpw">New Password</label>
								{{ form.render('newpw') }}
							</div>
							<div class="form-group">
								<label for="newpw2">Confirm New Password</label>
								{{ form.render('newpw2') }}
							</div>
						</div>
					</div>
					
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
			</div>
		</div>
	</div>
	
</form>