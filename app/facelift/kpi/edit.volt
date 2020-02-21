<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Record</h6>
				<h4 class="header-title">Production KPI's</h4>
			</div>
			<div class="col text-right">
				<nav aria-label="Page navigation example">
					<ul class="pagination float-right">
						<li class="page-item">
							<a class="page-link" href="{{url('kpi/' ~ yesterday)}}" aria-label="Next">
								<span aria-hidden="true">&laquo;</span>
								<span class="sr-only">Next</span>
							</a>
						</li>
						<li class="page-item"><a class="page-link" href="{{ url("kpi") }}">Today</a></li>
						<li class="page-item"><a class="page-link" href="#">Select Date</a></li>
						<li class="page-item">
							<a class="page-link" href="{{ url('kpi/' ~ tomorrow) }}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
								<span class="sr-only">Next</span>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		<hr class="w-100">
		{{ flashSession.output() }}
		{{ content() }}
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">

			<h2>{{ date( 'l dS M', strtotime(date) ) }}</h2>

			<form action="/kpi/save" method="POST" role="form">

				<div class="form-group">
					{{ hidden_field('date', 'test', 'value': date ) }}
					{% for element in form %}
					{{ element.label() }}
					{{ element.render() }}
					{% endfor %}
				</div>

				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>
	</div>
</div>
<script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<script>
	$('#datepicker').datepicker({
		uiLibrary: 'bootstrap4'
	});
</script>
