<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous">{{ link_to("customers", "Go Back") }}</li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Create customers
    </h1>
</div>

{{ content() }}

{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}

{% for element in form %}
<div class="control-group">
    {{ element.label(['class': 'control-label']) }}
    <div class="controls">
        {{ element }}
    </div>
</div>
{% endfor %}

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        {{ submit_button('Save', 'class': 'btn btn-default') }}
    </div>
</div>

</form>
