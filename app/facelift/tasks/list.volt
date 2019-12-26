{{ content() }}

<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<form class="form-inline pull-right" role="form">

			<div class="form-group">
				<select id="dynamic_select" class="form-control">
				  {% for user in users %}
				    <option value="{{ static_url('/tasks/list/' ~ user.id) }}" {% if user.id === id %}selected="true"{% endif %}>{{  user.name }}</option>
				  {% endfor %}
				</select>
			</div>
			<div class="form-group">
				<input type="text" id="datatable-search" class="form-control" placeholder="Search">
			</div>
		</form>
	</div>
</div>

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <table class="table table-condensed table-hover table-hover tasks" id="tasks">
            <thead>
                <tr>
                    <th>Customer</th>
                    <th>Contact Date</th>
                    <th>Follow Up Date</th>
                    <th>Contact Type</th>
                    <th>Reference</th>
                </tr>
            </thead>
            <tbody>
                {% for item in overdue %}
                    {% if item.job is not null %}
                        {% set url = "/quotes/view/" ~ item.job ~ "/" %}
                    {% else %}
                        {% set url = "/customers/view/" ~ item.customerCode ~ "/" %}
                    {% endif %}
                <tr class="danger clickable-row" data-href="{{ url }}">
                    <td>{{ item.company.customerName }}</td>
                    <td>{{ item.date }}</td>
                    <td>{{ item.followUpDate }}</td>
                    <td>{{ item.type.name }}</td>
                    <td>{{ item.reference }}</td>
                </tr>
                {% endfor %}
                {% for item in today %}
                    {% if item.job is not null %}
                        {% set url = "/quotes/view/" ~ item.job ~ "/" %}
                    {% else %}
                        {% set url = "/customers/view/" ~ item.customerCode ~ "/" %}
                    {% endif %}
                <tr class="info clickable-row" data-toggle="modal" data-id="{{ loop.index }}" data-target="modal-ajax" data-href="{{ url }}">
                    <td>{{ item.company.customerName }}</td>
                    <td>{{ item.date }}</td>
                    <td>{{ item.followUpDate }}</td>
                    <td>{{ item.type.name }}</td>
                    <td>{{ item.reference }}</td>
                </tr>
                {% endfor %}
                {% for item in coming %}
                    {% if item.job is not null %}
                        {% set url = "/quotes/view/" ~ item.job ~ "/" %}
                    {% else %}
                        {% set url = "/customers/view/" ~ item.customerCode ~ "/" %}
                    {% endif %}
                <tr class="clickable-row" data-href="{{ url }}">
                    <td>{{ item.company.customerName }}</td>
                    <td>{{ item.date }}</td>
                    <td>{{ item.followUpDate }}</td>
                    <td>{{ item.type.name }}</td>
                    <td>{{ item.reference }}</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
    </div>
</div>

<style type="text/css">
.clickable-row {
    cursor: pointer;
    cursor: hand;
}
#tasks_wrapper .row:first-child {
    display: none;
}
</style>

<script type="text/javascript">
    $(document).ready(function() {
        oTable = $('#tasks').DataTable( {
            "paging":   false,
            "ordering": true,
            "info":     false,
            "search": 	false,
            "order": [[2, "asc"]]
        } );
		$('#datatable-search').keyup(function(){
		      oTable.search($(this).val()).draw() ;
		});
        jQuery(document).ready(function($) {
            $(".clickable-row").click(function() {
                window.document.location = $(this).data("href");
            });
        });
    } );
 $(function(){
  // bind change event to select
  $('#dynamic_select').on('change', function () {
      var url = $(this).val(); // get selected value
      if (url) { // require a URL
          window.location = url; // redirect
        }
        return false;
      });
	});
</script>
