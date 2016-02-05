{{ content() }}

<div class="row">
	<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Details</h3>
			</div>
			<div class="panel-body">
				Panel content
			</div>
		</div>

		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Follow Up</h3>
			</div>
			<div class="panel-body">
				Panel content
			</div>
		</div>
	</div>

	<div class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Items</h3>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Item</th>
								<th>Width</th>
								<th>Thickness</th>
								<th>Grade</th>
								<th>Treatment</th>
								<th>Dryness</th>
								<th>Finish</th>
								<th>Price</th>
								<th>Lineal</th>
							</tr>
						</thead>
						<tbody>
						{% for item in items %}
							<tr>
								<td>{{ item.id }}</td>
								<td>{{ item.width }}</td>
								<td>{{ item.thickness }}</td>
								<td>{{ item.grade }}</td>
								<td>{{ item.treatment }}</td>
								<td>{{ item.dryness }}</td>
								<td>{{ item.finish }}</td>
								<td>{{ item.price }}</td>
								<td>{{ item.linealTotal }}</td>
							</tr>
						{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>