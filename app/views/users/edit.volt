
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-4 col-md-offset-3 col-lg-offset-4">

        {{ content() }}
        {{ flashSession.output() }}

        <form action="/users/update" method="POST" role="form">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Personal Details</h3>
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
                    <h3 class="panel-title">
                        Groups
                    </h3>
                </div>
                <div class="panel-body">
                    <ul class="list-group">
                      <li class="list-group-item">
                          <label for="developer">
                              <input type="checkbox" name="developer" id="developer" {% if user.dev is 1 %}checked="checked"{% endif %}>
                              Developer
                          </label>
                          <br />
                          <em>Allow user to use developer features</em>
                      </li>
                      <li class="list-group-item">
                          <label for="admin">
                              <input type="checkbox" name="admin" id="admin" {% if user.profilesId is 1 %}checked="checked"{% endif %}>
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
                          <em>Temporarily ban user</em>
                      </li>
                      <li class="list-group-item">
                          <label for="banned">
                              <input type="checkbox" name="banned" id="banned" {% if user.banned is 1 %}checked="checked"{% endif %}>
                              Banned
                          </label>
                          <br />
                          <em>Ban the user </em>
                      </li>
                    </ul>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Reset Password</h3>
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

            <button type="submit" class="btn btn-primary">Submit</button>

        </form>
    </div>
</div>
