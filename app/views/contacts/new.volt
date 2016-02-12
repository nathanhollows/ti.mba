{{ content() }}

{{ form("contacts/create", "method":"post", "autocomplete" : "off") }}
    <div class="modal-body">
        {{ content() }}


        {% for element in form %}
            <div class="form-group">
                {{ element.label() }}
                {{ element }}
            </div>    
        {% endfor %}


    </div>
    </div>
