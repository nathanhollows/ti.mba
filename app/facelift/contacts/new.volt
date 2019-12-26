{{ form("contacts/create", "method":"post", "autocomplete" : "off") }}
    <div class="modal-body">
        {{ content() }}

        <div class="form-group">
            {{ form.label('name') }}
            {{ form.render('name') }}
        </div>

        <div class="form-group">
            {{ form.label('role') }}
            {{ form.render('role') }}
        </div>

        <div class="form-group">
            {{ form.label('customerCode') }}
            {{ form.render('customerCode') }}
        </div>

        <div class="form-group">
            {{ form.label('email') }}
            {{ form.render('email') }}
        </div>

        <div class="form-group">
            {{ form.label('directDial') }}
            {{ form.render('directDial') }}
        </div>

    </div>
    </div>
