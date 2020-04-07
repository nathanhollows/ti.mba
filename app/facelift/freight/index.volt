<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col col-md-6 offset-md-2">
				<h6 class="header-pretitle">Tracker</h6>
				<h4 class="header-title">Freight Tracker</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
	</div>
</div>

<div class="container">
	{{ content() }}
	<div class="row">
		<div class="col col-md-8 offset-md-2">
			{{ flashSession.output() }}
			<div class="alert alert-primary" role="alert">
				This system shows all Mainfreight deliveries. They are tracked every half an hour and disappear after being delivered.
				<br>
				<br>
				<ul>
					<li>The links do a track and trace</li>
					<li>Oldest despatches are the the top</li>
					<li>This only tracks Mainfreight and Mainfreight Offsite</li>
					<li>PBT can be added if required</li>
					<li>Con Notes must be loaded in TimberSmart</li>
					<li>Clicking the tick marks the line as delivered</li>
				</ul>
			</div>
			<ul class="list-group">
				{% set recent = false %}
				{% set delayed = false %}

				{% for item in outstanding %}

				{% if strtotime(item.date) < strtotime('Today - 1 Week') and delayed is false %}
			 {% set delayed = true %}
			</ul>
			<ul class="list-group">
				{% endif %}

				{% if strtotime(item.date) > strtotime('Today - 1 week') and recent is false %}
				{% set recent = true %}
			</ul>
			<ul class="list-group">
				{% endif %}
				<li class="list-group-item" id="{{ item.docketNo }}">
					{% if "Mainfreight" in item.carrier %}
					<a href="https://www.mainfreight.com/Track/MSNZS/{{ item.carrierLabel }}" target="_blank" title="Track and Trace">{{ item.conNote }}</a>
					{% elseif  "PBT" in item.carrier %}
					<a href="http://www.pbt.co.nz/nick/results.cfm?ticketNo={{ item.conNote }}" target="_blank" title="Track and Trace">{{ item.conNote }}</a>
					{% endif %}
					{% if item.order %}
					{{ item.order.orderNumber }}
					{% if item.order.customer %}
					{{ item.order.customer.customerName }}
					{% endif %}
					{% endif %}
					<span class="float-right">
						{% if item.status %}
						{% if item.red > 1 %}
						<span class="badge badge-danger" title="Status has not changed in {{ item.red }} days">{{ item.status }}</span>
						{% elseif "Received" in item.status %}
						<span class="badge badge-secondary" title="Consignment not loaded into Mainchain">{{ item.status }}</span>
						{% else %}
						<span class="badge badge-info" title="Picked up an in transit">{{ item.status }}</span>
						{% endif %}
						{% endif %}
						<span>{{ date("dS M", strtotime(item.date)) }}</span>
						{#
						{% if item.emailed is 1 %}
						<a class="sent"><img src="{{ url('img/icons/mail.svg') }}"></img></a>
						{% elseif "Mainfreight" in item.carrier %}
						<a class="mail" href="/freight/mail/mainfreight/{{ item.conNote }}" data-connote="{{ item.conNote }}" title="Email Customer 
						Service"><img src="{{ url('img/icons/mail.svg') }}" class="feather"></img></a>
						{% elseif "Peter" in item.carrier %}
						<a class="mail" href="/freight/mail/pbt/{{ item.conNote }}" data-connote="{{ item.conNote }}" title="Email Customer Service"><img src="{{ url('img/icons/mail.svg') }}" class="feather"></img></a>
						{% endif %}
						#}
						<a class="delivered" data-docket="{{ item.docketNo }}"><img src="{{ url('img/icons/check.svg') }}" class="feather"></img></a>
					</span>
				</li>
				{% endfor %}
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
	$( document ).ready(function() {
		$('.delivered').click(function(event) {
			event.preventDefault();
			var docket = $( this ).data("docket");
			var request = $.ajax({
				url: "/freight/update",
				type: "POST",
				data: {id : docket},
				dataType: "html"
			});

			request.done(function() {
				$("#" + docket ).fadeOut("normal", function() {
					$(this).remove();
				});
			});

			request.fail(function(jqXHR, textStatus) {
				alert( "Request failed: " + textStatus );
			});
		});

		$('.mail').click(function(event) {
			event.preventDefault();
			$( this ).removeClass('mail').addClass('sent');
			var conNote = $( this ).data("connote");
			var link = $( this ).attr("href");
			var request = $.ajax({
				url: link,
				type: "POST",
				dataType: "html"
			});

			request.done(function() {
				// TODO: Success should be indicated somehow instead of assumed
			});

			request.fail(function(jqXHR, textStatus) {
				alert( "Request failed" );
			});
		});
	})
</script>
<style media="screen">
a {
	cursor: hand;
}
a.sent {
	cursor: not-allowed;
	color: gainsboro;
}
</style>
