<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Editing</h6>
				<h4 class="header-title">Preferences</h4>
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

			<form action="" method="POST" role="form">

				<div class="panel panel-default">
					<div class="panel-heading">
						<h5 class="panel-title">Personal Details</h5>
					</div>
					<div class="panel-body">
						<div class="form-group">
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
						<h5 class="panel-title">Password</h5>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label for="currentPass">Current Password <span class="text-danger">(Required)</span></label>
							{{ form.render('currentPass') }}
						</div>
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

				<button type="submit" class="btn btn-primary">Submit</button>

			</form>
		</div>
	</div>
</div>
