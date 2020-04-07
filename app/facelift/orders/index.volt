<div class="container">
	<div class="row">
		{#
		<div class="hidden-sm hidden-xs col-md-3 col-lg-3 col">
			<div class="card shadow">
				<div class="card-header bg-white font-weight-bold">
					Historic Orders
				</div>
				<div class="panel-body">
					<input id="customer-search" name="search" placeholder="Search by customer name" type="text" data-list=".customers" class="form-control border-0" accesskey="c" autocomplete="off">
				</div>
				<div class="scroll">
					<li class="list-group-item">
						<a class="show-outstanding text-primary">Outstanding Orders</a>
					</li>
					<ul class="list-group list-group-flush customers">
						{% for customer in customers %}
						<li class="list-group-item">
							<a class="show-customer" data-customer="{{ customer.customerCode }}">{{ customer.customerName }}</a>
							<span class="d-none">{{ customer.customerCode }}</span>
						</li>
						{% endfor %}
					</ul>
				</div>
			</div>
		</div>
		#}
		<div class="col p-0" id="orderlist">
			<div class="card shadow">
				<div class="card-header bg-white font-weight-bold">
					Outstanding Orders (<span id="count"></span>)
				</div>
				<div class="panel-body">
					<input id="list-search" name="search" placeholder="Search by name, order number, sales rep, location ..." type="text" data-list=".list" class="form-control border-0 shadow-sm" accesskey="s" autocomplete="off" autofocus="true">
				</div>
				<div class="panel-body scroll">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Order</th>
								<th>Customer</th>
								<th>Date</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody class="list">
							{% for order in orders %}
							<tr class="order-listing" data-order="{{ order.orderNumber }}">
								<td>
									{{ order.orderNumber }}
									<span hidden>{{ order.rep }}</span>
								</td>
								{% if order.customerCode is null %}
								<td></td>
								{% else %}
								<td>{% if order.customer %}{{ order.customer.customerName}}{% endif %}<br>
									{{ order.customerRef }}</td>
								{% endif %}
								<td>{{ date("M d", strtotime(order.date)) }} <br>
									{% if order.eta %}{{ date("M d", strtotime(order.eta)) }} {% endif %}</td>
								<td>
									<p>
									{% if order.scheduled is 1 %}
									<span class="badge badge-success">Scheduled</span>
									{% elseif order.followUp is 1 %}
									<span class="badge badge-warning">Follow Up</span>
									{% endif %}
									</p>
									<p>{% if order.location %} <span class="badge badge-dark">{{ order.whereabouts.name }}</span> {% endif %}</p>
								</td>
							</tr>
							{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-5"  id="order-details">
			{{ flashSession.output() }}
			{{ content() }}
			<div class="card shadow">
				<div class="card-header bg-white font-weight-bold">
					Summary
				</div>
				<div class="card-body">
					<dl class="dl-horizontal">
						{% for location in countLocations %}
						<dt>{{ location.location }}</dt>
						<dd>{{ location.total }}</dd>
						{% endfor %}
						<dt>Scheduled</dt> 
						<dd></dd>
						<dt>Total Orders</dt>
						<dd><strong>{{ orders|length }}</strong></dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<style media="screen">
a {
	cursor: hand;
}
.col {
	padding: 5px;
}
span.editable-container.editable-inline, .control-group.form-group, .editable-input, textarea.form-control.input-large {
	width: 100%;
	float: left;
	clear: right;
}
.editable-buttons {
	float: left;
	margin-top: 10px;
}
.prev:before {
	content: "\2190 ";
}

.next:before {
	content: "\2192 ";
}
.editable-clear {
	display: none;
}
.editable-input {
	width: 100%;
	float: left;
	clear: both;
}
.editable-buttons {
	margin: 10 0;
	clear: left;
	width: 100%;
}
.panel-footer.note {
	background: #f6bb42;
	border-top-color: #f6bb42;
	color: white;
}

.col ::-webkit-scrollbar {
	width: 6px;
	background: transparent; /* make scrollbar transparent */
}
.col ::-webkit-scrollbar-thumb {
	background: #aab2bd; 
	border-radius: 6px;
}
.panel-body.scroll{
	max-height: calc(100vh - 210px);
	overflow-y: scroll;
}
</style>
<script src="/js/hideseek.min.js"></script>
<script>

	$( document ).ready( function() {
		$('#list-search').hideseek({
			throttle: 500
		});
		$('#customer-search').hideseek({
			ignore: '.ignore',
			hidden_mode: true
		});
		$('#count').html( $('.table').find('.list > tr:visible').length );
		$('#list-search').on("_after_each", function() {
			$( '#count' ).html( $('.table').find('.list > tr:visible').length );
		});
		$('body').on('click', '.order-listing', function (){
			order( $( this ).data('order'));
			$('tr.table-active').removeClass('table-active');
			$(this).addClass('table-active');
		});
		$("a.show-customer").click(function() {
			customer( $( this ).data('customer'));
			$('tr.table-active').removeClass('table-active');
			$(this).parents().eq(1).addClass('table-active');
		});
		$("a.show-outstanding").click(function() {
			outstanding();
		});
	});

var xhr;
var order = function(id)
{
	if(xhr && xhr.readyState != 4){
		xhr.abort();
	}
	xhr = $.ajax({

		type: "GET",
		url: '/orders/view/' +id,
		success: function(data) {
			$('#order-details').html(data);
			// $('.xedit').editable();
			$('button', this).button();
		}
	});
}
var customer = function(id)
{
	if(xhr && xhr.readyState != 4){
		xhr.abort();
	}
	xhr = $.ajax({

		type: "GET",
		url: '/orders/customer/' +id,
		success: function(data) {
			// data is ur summary
			$('#orderlist').html(data);
			// $('.xedit').editable();
			$('button', this).button();
		}
	});
}
var outstanding = function(id)
{
	if(xhr && xhr.readyState != 4){
		xhr.abort();
	}
	xhr = $.ajax({

		type: "GET",
		url: '/orders/outstanding/',
		success: function(data) {
			// data is ur summary
			$('#orderlist').html(data);
			// $('.xedit').editable();
			$('button', this).button();
		}
	});
}
$( document ).ajaxComplete(function() {
	$('#list-search').hideseek({
		throttle: 500
	});
	$('#count').html( $('.table').find('.list > tr:visible').length );
	$('#list-search').on("_after_each", function() {
		$( '#count' ).html( $('.table').find('.list > tr:visible').length );
	});
	$(".toggle-status").click(function(){
		var target = $(this);
		var pk = $(this).data("order");
		var name = $(this).data("name");
		jQuery.ajax({
			type: "POST",
			url: "/orders/update",
			data: { 'pk': pk , 'name': name},
			dataType: 'json',
			cache: false,
			error: function (data) {
				alert('Something went wrong!');
			}
		});
	});
});
$(window).keydown(function(e){
	if($("input,textarea,select").is(":focus")){
		return;
	}else if(e.which === 40){
		$( 'tr.table-active' ).removeClass('table-active').nextAll('tr:visible:first').addClass('table-active');
		if (!$( 'tr.table-active' ).data('order')) {
			$('.list tr:visible:first ').addClass('table-active');
			order( $( 'tr.table-active' ).data('order'));
		} else {
			order( $( 'tr.table-active' ).data('order'));

		}
	}else if(e.which === 38){
		$( 'tr.table-active' ).removeClass('table-active').prevAll('tr:visible:first').addClass('table-active');
		if (!$( 'tr.table-active' ).data('order')) {
			$('.list tr:visible:last ').addClass('table-active');
			order( $( 'tr.table-active' ).data('order'));
		} else {
			order( $( 'tr.table-active' ).data('order'));
		}
	}
});
</script>
