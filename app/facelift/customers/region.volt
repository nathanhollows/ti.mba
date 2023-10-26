<div class="container">
	<div class="header py-3">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">{{ region.name }}</h4>
				<h6>{{ region.rep.name }} | {{ region.customers|length }} customers</h6>
			</div>
			<div class="col text-right">
			</div>
		</div>
		<hr class="w-100">
	</div>

	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>

	<div class="row">
		<div class="col">
			<ul class="list-group list-group flush shadow-sm">
				<li class="list-group-item">
					<strong>Top Customers - past year</strong>
				</li>
				{% for customer in region.getTopCustomers(strtotime("now - 1 year")) %}
				<li class="list-group-item">{{ linkTo("customers/view/"~customer.customerCode, customer.name) }}
					<span class="float-right">${{ customer.value|number }}</span>
				</li>
				{% endfor %}
			</ul>
		</div>
		<div class="col">
			<ul class="list-group list-group flush shadow-sm">
				<li class="list-group-item">
					<strong>Top Customers - past month</strong>
				</li>
				{% for customer in region.getTopCustomers(strtotime("now - 1 month")) %}
				<li class="list-group-item">{{ linkTo("customers/view/"~customer.customerCode, customer.name) }}
					<span class="float-right">${{ customer.value|number }}</span>
				</li>
				{% endfor %}
			</ul>
		</div>
	</div>

</div>
