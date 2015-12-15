{{ content() }}

<ul class="pager">
    <li class="previous pull-left">
        {{ link_to("customers/index", "&larr; Go Back") }}
    </li>
    <li class="pull-right">
        {{ link_to("customers/new", "Create New") }}
    </li>
</ul>

{{ form("customers/search") }}

<fieldset>

<div class="control-group">
    <div class="controls">
    </div>
</div>
    <div class="input-group">
      {{ text_field("customerCode", "size" : 30, "class" : "form-control", "id" : "fieldCustomercode", "placeholder": "Search for ...") }}
      <span class="input-group-btn">
      {{ submit_button("Search", "class": "btn btn-default") }}
      </span>
    </div><!-- /input-group -->

</fieldset>

</form>

{% for customers in page.items %}
{% if loop.first %}
<table class="table table-bordered table-striped" align="center">
    <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Telephone</th>
            <th class="hidden-xs">Fax</th>
            <th class="hidden-xs">Status</th>
        </tr>
    </thead>
{% endif %}
    <tbody>
        <tr>
            <td>{{ link_to("customers/view/" ~ customers.customerCode, customers.customerCode) }}</td>
            <td>{{ customers.customerName }}</td>
            <td>{{ customers.customerPhone }}</td>
            <td class="hidden-xs">{{ customers.customerFax }}</td>
            <td class="hidden-xs">
                {% if customers.status %}
                    <span class="label label-{{ customers.status.style }}">
                        {{ customers.status.name }}
                    </span>
                {% endif %}
            </td>
        </tr>
    </tbody>
{% if loop.last %}
    <tbody>
        <tr>
            <td colspan="7" align="right">
                <div class="btn-group">
                    {{ link_to("customers/search", '<i class="icon-fast-backward"></i> First', "class": "btn btn-default") }}
                    {{ link_to("customers/search?page=" ~ page.before, '<i class="icon-step-backward"></i> Previous', "class": "btn btn-default") }}
                    {{ link_to("customers/search?page=" ~ page.next, '<i class="icon-step-forward"></i> Next', "class": "btn btn-default") }}
                    {{ link_to("customers/search?page=" ~ page.last, '<i class="icon-fast-forward"></i> Last', "class": "btn btn-default") }}
                    <span class="help-inline">{{ page.current }}/{{ page.total_pages }}</span>
                </div>
            </td>
        </tr>
    <tbody>
</table>
{% endif %}
{% else %}
    No customers are recorded
{% endfor %}