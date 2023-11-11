<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col col-md-6 offset-md-2">
				<h4 class="header-title">Mainfreight Tracker</h4>
				<h6 class="pre-header">Checked every half hour</div>
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
			{% set delayed = true %}
			<ul class="list-group">
				{% for item in outstanding %}

				{% if delayed and strtotime(item.date) > strtotime('Today - 1 Week') %}
				{% set delayed = false %}
				{% endif %}

				<li class="list-group-item {% if delayed %}list-group-item-danger{% endif %}" id="{{ item.docketNo }}">
					{% if "Mainfreight" in item.carrier.name %}
					{% if item.carrierLabel %}
					<a href="https://www.mainfreight.com/Track/MSNZS/{{ item.carrierLabel }}" target="_blank" title="Track and Trace">{{ item.conNote }}</a>
					{% else %}
					{{ item.conNote }}
					{% endif %}
					{% elseif  "PBT" in item.carrier %}
					<a href="http://www.pbt.co.nz/nick/results.cfm?ticketNo={{ item.conNote }}" target="_blank" title="Track and Trace">{{ item.conNote }}</a>
					{% endif %}
					{% if item.order %}
					{{ item.order.orderNumber }}
					{% if item.order.customer %}
					{{ item.order.customer.name }}
					{% endif %}
					{% endif %}
					<span class="float-right">
						{% if delayed %}
						<span class="badge badge-danger">{{ ((strtotime(date("Y-m-d")) - strtotime(item.date)) / (60 * 60 * 24))|round }} days</span>
						{% endif %}

						{% if item.status %}
						{% if "Received" in item.status %}
						<span class="badge badge-secondary" title="Consignment not loaded into Mainchain">{{ item.status }}</span>
						{% else %}
						<span class="badge badge-info" title="Picked up and in transit">{{ item.status }}</span>
						{% endif %}
						{% else %}
						<span class="badge badge-secondary" title="Not tracked">Not tracked</span>
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
						<a class="delivered text-primary" title="Mark as delivered" data-docket="{{ item.docketNo }}"><img src="/img/icons/check.svg" class="feather"></img></a>
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
	cursor: pointer;
}
a.sent {
	cursor: not-allowed;
	color: gainsboro;
}
</style>
