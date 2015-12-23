{{ content() }}

<div class="row">
	<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Customer Details</h3>
			</div>
			<div class="panel-body">
				<ul class="list-group">
					<li class="list-group-item">Item 1</li>
					<li class="list-group-item">Item 2</li>
					<li class="list-group-item">Item 3</li>
				</ul>
			</div>
		</div>
	</div>	
	<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Panel title</h3>
			</div>
			<div class="panel-body">
				Panel content
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<table class="table table-condensed table-hover">
			<thead>
				<tr>
					<th>Line</th>
					<th>Width</th>
					<th>Thickness</th>
					<th>Grade</th>
					<th>Treatment</th>
					<th>Dryness</th>
					<th>Finish</th>
					<th>Notes</th>
					<th>Cost</th>
					<th>Method</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
				</tr>
				<tr>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
				</tr>
				<tr>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
					<td>Blah</td>
				</tr>
			</tbody>
		</table>	
	</div>	
</div>

{{ form("quotes/create", "method":"post", "autocomplete" : "off") }}

{% for element in form %}
<div class="form-group">
	{{ element.label() }}
	{{ element }}
</div>    
{% endfor %}
</form>