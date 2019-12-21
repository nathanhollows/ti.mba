
<div class="row">
	<ul class="pager">
		<li>{{ link_to('kpi/dailysales/' ~ yesterday, 'Previous') }}</li>
		<li>{{ link_to('kpi/dailysales/', 'Today') }}</li>
		<li><a id="datebutton"><input type="text" name="" id="datepicker" class="form-control" value="" required="required" pattern="" title="" hidden="true" data-date-format='yyyy/mm/dd'><i class="fa fa-icon fa-calendar"></i> Select Date</a></li>
		<li>{{ link_to('kpi/dailysales/' ~ tomorrow, 'Next') }}</li>
	</ul>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3 ">
		{{ content() }}
		{{ flashSession.output() }}
		<form action="/kpi/savesales" method="POST" role="form" id="foo">
			<table data-editable data-editable-spy class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>Rep</th>
						<th>Quoted</th>
						<th>Reference</th>
						<th>Value</th>
					</tr>
				</thead>

				<tbody>
					{# Loop through the days items #}
					{% set value = 0%}
					{% for item in records %}
					<tr class="record">
						<td>
							<a href="#" data-href="/kpi/deletesale/{{ item.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete"><i class="fa fa-times"></i></a>
						</td>
						<td>
							{{ hidden_field('id[]', 'value': item.id) }}
							{{ hidden_field('timestamp[]', 'value': item.timestamp) }}
							{{ select_static('rep[]', users, 'using': ['id', 'name'], 'value': item.rep, 'class': 'data') }}
						</td>
						<td>
							{{ check_field('quoted[]','value': '0', 'hidden': 'true', 'checked': 'true') }}
							{% if item.quoted == 0 %}
							{{ check_field('quoted[]','value': '1', 'class', 'data') }}
							{% else %}
							{{ check_field('quoted[]','value': '1', 'class', 'data', 'checked': 'true') }}
							{% endif %}
						</td>
						<td>
							{{ text_field('customerReference[]', 'value': item.customerReference ) }}
						</td>
						<td>
							{{ numeric_field('amount[]', 'value': item.value, 'step': 'any') }}
						</td>
						{% set value = value + item.value %}
					</tr>
					{% endfor %}
					<!-- The last <tr> in the <tbody> will be used as template for new rows -->
					<tr>
						<td></td>
						<td>
							{{ form.render('id[]') }}
							{{ form.render('date') }}
							{{ form.render('rep[]') }}
						</td>
						<td>{{ check_field('quoted[]','value': '0', 'checked': true, 'hidden': true) }}
							{{ form.render('quoted[]') }}</td>
							<td>{{ form.render('customerReference[]') }}</td>
							<td>
								{{ form.render('amount[]') }}
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<th></th>
							<th>Rep</th>
							<th>Quoted</th>
							<th>Reference</th>
							<th>Value</th>
						</tr>
					</tfoot>
				</table>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
		<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
			<ul class="list-group">
				<li class="list-group-item active">
					Summary
				</li>
				{% for item in salesByAgent %}
				<li class="list-group-item">
					{% for user in users %}
					{% if user.id == item.rep %}
					{{ user.name }}
					{% break %}
					{% endif %}
					{% endfor %}
					<span class="pull-right"> ${{ item.sumatory|number }}</span>
				</li>
				{% endfor %}
				<li class="list-group-item">
					<strong>Total</strong>
					<span class="pull-right"> <strong>${{ total|number }} </strong></span>
				</li>
				<li class="list-group-item">
					<strong>Week Total</strong>
					<span class="pull-right"> <strong>${{ weekTotal|number }} </strong></span>
				</li>
			</ul>
            <ul class="list-group">
                <li class="list-group-item active">Daily Budget</li>
                <li class="list-group-item">
                        <b>Target: </b><span class="pull-right">${{ (budget.budget/budget.days)|number }}</span>
                        <br />
                        <br />
                        <div class="progress">
                            {% if (total/(budget.budget/budget.days))*100 >= 100 %}
                                {% set progress = 100 %}
                                {% set label = (total/(budget.budget/budget.days))*100 %}
                                {% set status = '-success' %}
                            {% else %}
                                {% set status = '-warning' %}
                                {% set progress = ((total/(budget.budget/budget.days))*100)|number %}
                                {% set label = progress %}
                            {% endif %}
                          <div class="progress-bar progress-bar{{ status }} " role="progressbar" aria-valuenow="{{ progress }}" aria-valuemin="0" aria-valuemax="100" style="width: {{ progress }}%;">{{ label|number }}%
                            <span class="sr-only"></span>
                          </div>
                        </div>
                </li>
            </ul>
		</div>
	</div>

	<style type="text/css">
		select.data {
			width: 100%;
			background: transparent;
			border: 0;
		}
		.record:hover a.delete, .active a.delete {
			visibility: visible;
		}

		a.delete {
			visibility: hidden;
		}
		.datepicker.datepicker-dropdown.dropdown-menu {
			background: white;
		}
		input#datepicker {
		    height: 0px;
		    width: 0px;
		    padding: 0;
		    border: none;
		    visibility: hidden;
		    display: inline;
		    margin-top: 10px;
		}
	</style>
	<script type="text/javascript">
		$(function () {
			$("#datepicker")
			    .datepicker({
			      dateFormat: "yy/mm/dd",
			      onSelect: function(dateText) {
			        $(this).change();
			      }
			    })
			    .change(function() {
			      window.location.href = "/kpi/dailysales/" + this.value;
			    });
				$('#datebutton').click(function() {
				      $('#datepicker').datepicker('show');
				});
		});
	</script>
