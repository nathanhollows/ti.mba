<div class="row">
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<ul class="list-group">
			<li class="list-group-item active">
				<h4>Todo <span class="badge">{{ tasks|length }}</span>
				</h4>
			</li>			
			{% for item in tasks %}
			<li class="list-group-item">
				{{ parser.parse(item.details) }}
			</li>
			{% endfor %}
		</ul>
	</div>
</div>