{{ content() }}

{{ form('/orders/import', 'method': 'post', 'class': 'form-horizontal', 'role': 'form') }}
  <div class="form-group">
    <label for="orderDump" class="col-sm-2 control-label">Order Dump</label>
    <div class="col-sm-10">
		{{ text_area('orderDump', 'class': 'form-control', 'placeholder': 'Order Dump') }}
    </div>
  </div>
  <div class="form-group">
    <label for="itemDump" class="col-sm-2 control-label">Item Dump</label>
    <div class="col-sm-10">
		{{ text_area('itemDump', 'class': 'form-control', 'placeholder': 'Item Dump') }}
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default">Update</button>
    </div>
  </div>
{{ end_form() }}

{% if orderDump is not empty %}
<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
<pre>
  {{ dump(orderDump, true) }}
</pre>
</div>
{% endif %}

{% if itemDump is not empty %}
<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
<pre>
  {{ dump(itemDump, true) }}
</pre>
</div>
{% endif %}