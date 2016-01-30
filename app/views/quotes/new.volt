{{ content() }}


<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
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
</div>