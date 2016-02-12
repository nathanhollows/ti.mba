<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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
