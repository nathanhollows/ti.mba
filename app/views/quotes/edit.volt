<form action="/quotes/update/" method="POST" role="form">
<div class="modal-body">
	{% for item in form %}
	<div class="form-group">
		{{ item.label() }}
		{{ item }}
	</div>
	{% endfor %}
</div>