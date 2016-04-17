<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	{% if pageTitle is not empty %}
		<h4>{{ pageTitle }}</h4>
	{% else %}
		<h4>Form</h4>
	{% endif %}
</div>

{{ content() }}

<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	{{ submit_button('Save', 'class': 'btn btn-primary')}}
</div>
</form>