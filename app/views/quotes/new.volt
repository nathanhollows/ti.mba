{{ content() }}


{{ form("quotes/create", "method":"post", "autocomplete" : "off") }}
<div class="modal-body">
 	{% if ajax is false %}
<div class="col-xs-12 col-sm-12 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
	{% endif %}
	<div class="form-group">
		<label>Customer</label>
		{{ form.render('customerCode') }}
	</div>    
	<div class="form-group">
		<label>Contact</label>
		{{ form.render('contact') }}
	</div>    
	<div class="form-group">
		<label>Reference</label>
		{{ form.render('reference') }}
	</div>    
	<div class="form-group">
		<label>Date</label>
		{{ form.render('date') }}
	</div>    
	<div class="form-group">
		<label>Notes</label>
		{{ form.render('notes') }}
	</div>  
	<div class="form-group">
		<label>Private Notes</label>
		{{ form.render('moreNotes') }}
	</div>    
	<div class="form-group">
		<label>Sales Rep</label>
		{{ form.render('user') }}
	</div>    
	<div class="form-group">
		<label>Status</label>
		{{ form.render('status') }}
	</div>    
 	{% if ajax is false %}
		<div class="form-group">
			{{ form.render('Submit') }}
		</div>    
		</div>    
	{% endif %}
</form>

</div>