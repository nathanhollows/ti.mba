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
            <a href="{{ url('settings/salesareas') }}" class="btn btn-primary">Sales Areas</a>
            <a href="{{ url('users') }}" class="btn btn-primary">Users</a>
            <hr>
            <p><strong>
                Developer Settings: Cache Busting
            </strong></p>
            <a href="{{ url('settings/clearcache/models') }}" class="btn btn-danger {% if not developer %}disabled{% endif %}"">Queries</a>
            <a href="{{ url('settings/clearcache/metadata') }}" class="btn btn-danger {% if not developer %}disabled{% endif %}"">Models MetaData</a>
            <a href="{{ url('settings/clearcache/volt') }}" class="btn btn-danger {% if not developer %}disabled{% endif %}"">Volt</a>
            {% if algoliaEnabled %}
            <hr>
            <p><strong>
                Algolia
            </strong></p>
            <a href="{{ url('settings/updatealgolia') }}" class="btn btn-info {% if not developer %}disabled{% endif %}"">Refresh Algolia index</a>
            {% endif %}
        </div>
    </div>
</div>
