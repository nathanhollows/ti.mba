{{ content() }}

<form action="{{ static_url('followup/setreminder') }}" method="POST" role="form">
	<div class="modal-body">

		<div class="row">
				{{ form.render('uri') }}
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<label>The When</label> <br>
				{{ form.render('followUpDate') }}
			</div>

			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<label>The Who</label> <br>
				{{ form.render('followUpUser') }}
			</div>

			<hr>

			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<label>The What</label>
				{{ form.render('notes') }}
			</div>
		</div>
	</div>
