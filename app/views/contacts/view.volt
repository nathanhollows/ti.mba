{{ content() }}

<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Cotnact Details</h3>
		</div>
		<div class="panel-body">
			{{ contact.name }}<br>
			{{ contact.email }}<br>
			{{ contact.directDial }}<br>
			{{ contact.position }}<br>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Organisation</h3>
		</div>
		<div class="panel-body">
			{{ link_to("customers/view/" ~ contact.company.customerCode, contact.company.customerName) }}<br>
			{{ contact.company.customerPhone }}
		</div>
	</div>
</div>

<div class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
	<div class="row">

		{{ partial('timeline') }}

	</div>
</div>