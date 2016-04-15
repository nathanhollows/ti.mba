<form>
<div class="modal-body">
	{% for item in form %}
	<div class="form-group">
		{{ item.label() }}
		{{ item.render() }}
	</div>
	{% endfor %}
</div>