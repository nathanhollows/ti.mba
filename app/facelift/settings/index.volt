{{ content() }}
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
        <div class="panel panel-default">
            <div class="panel-body">
                <ul class="nav nav-pills nav-stacked" role="tablist">
                    <li role="presentation" class="active"><a href="#general" aria-controls="home" role="tab" data-toggle="tab">General</a></li>
                    <li role="presentation"><a href="#email" aria-controls="profile" role="tab" data-toggle="tab">Email</a></li>
                    <li role="presentation"><a href="#regions" aria-controls="settings" role="tab" data-toggle="tab">Sales Areas</a></li>
                </ul>
            </div>
        </div>
    </div>
    <form method="POST">
    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="general">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            General
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="alert alert-dismissible alert-success">These settings can be changed in <code>/app/config.php</code></div>
                        <div class="col-xs-12 col-sm-12 col-sm-8 col-lg-6">
                            <label for="name">Site Name</label>
                            <input type="text" name="name" value="{{ config.application.siteTitle }}" readonly="true" class="form-control">
                            <br />

                            <label>Base URI</label>
                            <input type="text" name="name" value="{{ config.application.baseUri }}" class="form-control" readonly="true">
                            <br />

                            <label>Public URL</label>
                            <input type="text" name="name" value="{{ config.application.publicUrl }}" class="form-control" readonly="true">
                            <br />

                            <label>Crypt Salt</label>
                            <input type="text" name="name" value="Hidden" class="form-control" readonly="true">
                            <br />

                            <label for="">Database Adapter</label>
                            <input type="text" name="name" value="{{ config.database.adapter }}" class="form-control" readonly="true">
                            <br />

                            <label for="">Database Host</label>
                            <input type="text" name="name" value="{{ config.database.host }}" class="form-control" readonly="true">
                            <br />

                            <label for="">Database Username</label>
                            <input type="text" name="name" value="{{ config.database.username }}" class="form-control" readonly="true">
                            <br />

                            <label for="">Database Name</label>
                            <input type="text" name="name" value="{{ config.database.dbname }}" class="form-control" readonly="true">

                            <label for="">Database Password</label>
                            <input type="password" name="name" value="hidden" class="form-control " readonly="true">
                        </div>
                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="email">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Email
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="alert alert-dismissible alert-success">These settings can be changed in <code>/app/config.php</code></div>
                        <div class="col-xs-12 col-sm-12 col-sm-8 col-lg-6">
                        <label>From Address</label>
                        <input type="text" name="name" value="{{ config.mail.fromEmail }}" class="form-control" readonly="true">
                        <br />

                        <label>From Name</label>
                        <input type="text" name="name" value="{{ config.mail.fromName }}" class="form-control" readonly="true">
                        <br />

                        <label>SMTP Server</label>
                        <input type="text" name="name" value="{{ config.mail.smtp.server }}" class="form-control" readonly="true">
                        <br />

                        <label>SMTP Port</label>
                        <input type="text" name="name" value="{{ config.mail.smtp.port }}" class="form-control" readonly="true">
                        <br />

                        <label>SMTP Security</label>
                        <input type="text" name="name" value="{{ config.mail.smtp.security }}" class="form-control" readonly="true">
                        <br />

                        <label>SMTP Username</label>
                        <input type="text" name="name" value="{{ config.mail.smtp.username }}" class="form-control" readonly="true">
                        <br />

                        <label>SMTP Password</label>
                        <input type="password" name="name" value="hidden" class="form-control" readonly="true">
                        </div>
                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="regions">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Sales Areas
                        </h3>
                    </div>
                    <div class="panel-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Region</th>
                                    {% for rep in reps %}
                                    <th align="center">{{ rep.name }}</th>
                                    {% endfor %}
                                </tr>
                            </thead>
                            <tbody>
                                {% for area in salesAreas %}
                                <tr>
                                    <th>{{ area.name }}</th>
                                    {% for rep in reps %}
                                    <td align="center">
                                        <label>
                                            <input type="radio" name="area{{ area.id }}" value="{{ rep.id }}" {% if area.rep.id == rep.id%}checked{% endif %}>
                                        </label>
                                    </td>
                                    {% endfor %}
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>
                </div>
            </div>
        </div>
        <input type="submit" class="btn btn-primary mb-2" value="Save all changes">
        </input>
    </div>
    </form>
</div>
<style media="screen">
.tab-content {
    padding: 0px;
}
</style>
