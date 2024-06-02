<table class="table table-condensed table-hover table-bordered table-striped quotes-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Customer</th>
            <th>Reference</th>
            <th>Contact</th>
            <th>Value</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        {% for quote in quotes %}
        <tr {% if quote.sale == 1 %}class="success"{% endif %}>
            <td>{{ quote.quoteId }}</td>
            <td>{{ quote.date }}</td>
            <td>{{ quote.customer.name }}</td>
            <td>{{ quote.reference }}</td>
            <td>{% if quote.customerContact is not empty %}{{ quote.customerContact.name }}{% else %}{{ quote.attention }}{% endif %}</td>
            <td align="right">${{ quote.value|number }}</td>
            <td><span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.name }}</span></td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<script type="text/javascript">
$(document).ready(function() {
    $('.quotes-table').DataTable({
        "order": [[ 6, "desc" ]],
        stateSave: true,
        "lengthMenu": [[15, 25, 50, -1], [15, 25, 50, "All"]]
    });
} );
</script>
