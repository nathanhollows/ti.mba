{{ content() }}

{{ form("customers/create", "method":"post", "autocomplete" : "off", "class" : "form-horizontal") }}



<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <h3 class="panel-title">General Info</h3>
    </div>
    <div class="panel-body">
        {% for element in form %}
        <div class="control-group">
            {{ element.label(['class': 'control-label']) }}
            <div class="controls">
                {{ element }}
            </div>
        </div>
        {% endfor %}
    </div>
</div>
</div>

<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
    <div class="panel">
          <div class="panel-heading">
                <h3 class="panel-title">Freight</h3>
          </div>
          <div class="panel-body">
                Panel content
          </div>
    </div> 
</div>


{{ submit_button('Save', 'class': 'btn btn-default') }}


</form>
