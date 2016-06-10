<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Details
				{% if order.complete is 1 %}
					<span class="label label-info">Complete</span>
				{% endif %}
				{% if order.scheduled is 1 and order.complete is 0 %}
					<span class="label label-info">Scheduled</span>
				{% endif %}
				</h3>
			</div>
			<div class="panel-body">
				{{ order.orderNumber }}<br>
				{{ order.customerRef }}<br>
				{{ order.date ~ " - about " ~ order.date|timeAgoDate }}<br>
				{{ order.description }}<br>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Customer</h3>
			</div>
			<div class="panel-body">
				<h4>{{ link_to('customers/view/' ~ order.customerCode|lower ,'<i class="fa fa-icon fa-building"></i> ' ~ order.customer.customerName) }}</h4>
				{% for address in order.customer.addresses %}
					{% if address.typeCode == 2 %}
						{{ address.line2 }} <br>
						{{ address.line3 }} <br>
						{{ address.zipCode }} <br>
						{{ address.city }} <br>
						{{ address.country }} <br>
					{% endif %}
				{% endfor %}
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Status and Location</h3>
			</div>
			<div class="panel-body">
				Location
				Status
				
			</div>
		</div>
	</div>	
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<ul class="list-group">
		{% for item in order.items %}
			<li class="list-group-item">
				{% if item.despatch %}
				<span class="label label-success pull-right">Scheduled</span>
				{% endif %}
				{{ item.itemNo }}.
				{{ item.width }} x {{ item.thickness }}
				{{ item.grade }}
				{{ item.treatment }}
				{{ item.dryness }}
				{{ item.finish }}<br>
				{{ item.sent }} / {{ item.ordered }} {{ item.unit }} supplied
			</li>
		{% endfor %}
		</ul>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		{{ partial('timeline') }}
	</div>
</div>