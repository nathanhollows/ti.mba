<div class="header py-3">
    <div class="container">
        <div class="row header-body">
            <div class="col">
                <h4 class="header-title">Settings</h4>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col">
            {{ content() }}
            {{ flash.output() }}
            {{ flashSession.output() }}
        </div>
    </div>
    <div class="row">
        <div class="col">
            <a href="{{ url('settings/salesareas') }}" class="btn btn-primary mb-2">Sales Areas</a>
            <a href="{{ url('users') }}" class="btn btn-primary mb-2">Users</a>
            <hr>
            <p><strong>
                Developer Settings: Cache Busting
            </strong></p>
            <a href="{{ url('settings/clearcache/models') }}" class="btn btn-primary mb-2 {% if not developer %}disabled{% endif %}"">Queries</a>
            <a href="{{ url('settings/clearcache/metadata') }}" class="btn btn-primary mb-2 {% if not developer %}disabled{% endif %}"">Models MetaData</a>
            <a href="{{ url('settings/clearcache/volt') }}" class="btn btn-primary mb-2 {% if not developer %}disabled{% endif %}"">Volt</a>
        </div>
    </div>
</div>
