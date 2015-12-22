<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">{{ pageTitle }}</h4>
</div>
<div class="modal-body">
    {{ content() }}

    {{ form("contacts/create", "method":"post", "autocomplete" : "off") }}

    {% for element in form %}
        <div class="form-group">
            {{ element.label() }}
            {{ element }}
        </div>    
    {% endfor %}


</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    {{ submit_button('Save', 'class': 'btn btn-primary')}}
    </form>
</div>
