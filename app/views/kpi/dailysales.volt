{{ content() }}

<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Agent</th>
					<th>Quoted</th>
					<th>Cust. Ref.</th>
					<th>Value</th>
				</tr>
			</thead>
			<tbody id="sales">
				<tr>
					<td>
						<select>
							<option>Choose...</option>
							<option>Dave</option>
							<option>Paul</option>
							<option>Brad</option>
							<option>Jimmy</option>
							<option>Fax</option>
						</select>
					</td>
					<td><input type="checkbox" name=""></td>
					<td><input type="text" name=""></td>
					<td><input type="number" step="any" name=""></td>
				</tr>
				<tr>
					<td>
						<select>
							<option>Choose...</option>
							<option>Dave</option>
							<option>Paul</option>
							<option>Brad</option>
							<option>Jimmy</option>
							<option>Fax</option>
						</select>
					</td>
					<td><input type="checkbox" name=""></td>
					<td><input type="text" name=""></td>
					<td><input type="number" step="any" name=""></td>
				</tr>
				<tr>
					<td>
						<select>
							<option>Choose...</option>
							<option>Dave</option>
							<option>Paul</option>
							<option>Brad</option>
							<option>Jimmy</option>
							<option>Fax</option>
						</select>
					</td>
					<td><input type="checkbox" name=""></td>
					<td><input type="text" name=""></td>
					<td><input type="number" step="any" name=""></td>
				</tr>
			</tbody>
			<tfoot>
				<th>Total Orders:</th>
				<td>1</td>
				<th>Total Value:</th>
				<td>$12.30</td>
			</tfoot>
		</table>
	</div>
</div>

<script type="text/javascript">
	$('td[contenteditable=true]').live('blur',function(){
		
		alert("Help!");
		
	});
</script>

<style type="text/css">

#sales td {
	padding: 0 !important;
}
#sales input, #sales select {
	outline: none;
	border: none;
	height: 25px;
	background: transparent;
	border-bottom: 2px solid transparent;
	transition: border-bottom 0.5s ease;
}

#sales imput:focus, #sales input:focus {
	border-bottom: 2px solid blue;
	height: 27px;
}
</style>