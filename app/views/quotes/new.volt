{{ content() }}


<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Quote Information</h3>
			</div>
			<div class="panel-body">
				{{ form("quotes/create", "method":"post", "autocomplete" : "off") }}

				{% for element in quoteForm %}
				<div class="form-group">
					{{ element.label() }}
					{{ element }}
				</div>    
				{% endfor %}
				</form>
			</div>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		<div class="panel panel-info">
			  <div class="panel-heading">
					<h3 class="panel-title">Follow up</h3>
			  </div>
			  <div class="panel-body">
					Panel content
			  </div>
		</div>
	</div>
</div>