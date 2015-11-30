{{ content() }}

<ul class="pager">
    <li class="previous pull-left">
        {{ link_to("customers/index", "&larr; Go Back") }}
    </li>
    <li class="pull-right">
        {{ link_to("customers/new", "Create customers") }}
    </li>
</ul>

{% for customers in page.items %}
{% if loop.first %}
<table class="table table-bordered table-striped" align="center">
    <thead>
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Telephone</th>
            <th>Fax</th>
            <th>Group</th>
        </tr>
    </thead>
{% endif %}
    <tbody>
        <tr>
            <td>{{ customers.customerCode }}</td>
            <td>{{ customers.customerName }}</td>
            <td>{{ customers.customerPhone }}</td>
            <td>{{ customers.customerFax }}</td>
            <td>{{ customers.customerGroup }}</td>
            <td width="7%">{{ link_to("customers/edit/" ~ customers.customerCode, '<i class="glyphicon glyphicon-edit"></i> Edit', "class": "btn btn-default") }}</td>
            <td width="7%">{{ link_to("customers/delete/" ~ customers.customerCode, '<i class="glyphicon glyphicon-remove"></i> Delete', "class": "btn btn-default") }}</td>
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