{{ content() }}


    		{{ form("quotes/create", "method":"post", "autocomplete" : "off") }}
    <div class="modal-body">

		{% for element in quoteForm %}
		<div class="form-group">
			{{ element.label() }}
			{{ element }}
		</div>    
		{% endfor %}
	</form>

	</div>