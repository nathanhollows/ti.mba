<div class="container-fluid" style="margin: 0 auto; max-width: min(100vw - 4em, 1600px);">
	<div class="row">
		<div class="d-none d-lg-block col-lg-3">
			<div class="card shadow w-100">
				<div class="card-header">
					<strong class="pt-2 d-inline-block">Historic Orders</strong>
					<input onClick="this.select();" id="customer-search" name="search" placeholder="Search ... " type="text" data-list=".customers" class="form-control w-25 float-right shadow-sm" accesskey="c" autocomplete="off">
				</div>
				<div class="scroll">
					<ul class="list-group list-group-flush customers">
						<li class="list-group-item border-top-0 border-left-0 border-right-0 sticky-top ignore show-outstanding active">
							<strong>All Active Orders</strong>
						</li>
						{% for customer in customers %}
						<li class="list-group-item show-customer" data-customer="{{ customer.customerCode }}">
							{{ customer.name }}
							<span class="d-none">{{ customer.customerCode }}</span>
						</li>
						{% endfor %}
					</ul>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-6 col-lg-4" id="orderlist">
			<div class="card shadow">
				<div class="card-header">
					<strong class="pt-2 d-inline-block">Outstanding Orders (<span id="count"></span>)</strong>
					<input onClick="this.select();" id="list-search" name="search" placeholder="Search.." type="text" data-list=".list" class="form-control shadow-sm w-25 float-right" accesskey="s" autocomplete="off" autofocus="true">
				</div>
				<div class="scroll">
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
								<td>{% if order.customer %}{{ order.customer.name}}{% else %}<em>{{ order.customerCode }}</em>{% endif %}<br>
									{{ order.customerRef }}</td>
								{% endif %}
								<td>{{ date("d M", strtotime(order.date)) }} <br>
									{% if order.eta %}{{ date("d M", strtotime(order.eta)) }} {% endif %}</td>
								<td class="badges">
									{% if order.scheduled is 1 %}
									<span class="badge badge-success">Scheduled</span>
									{% elseif order.followUp is 1 %}
									<span class="badge badge-warning">Follow Up</span>
									{% endif %}
									{% if order.location %} <span class="badge badge-dark">{{ order.whereabouts.name }}</span> {% endif %}
								</td>
							</tr>
							{% endfor %}
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-6 col-lg-5"  id="order-details">
			{{ flashSession.output() }}
			{{ content() }}
			<div class="card shadow">
				<div class="card-header">
					<strong class="pt-2 pb-1 d-inline-block">
					Summary
					</strong>
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
.badges .badge {
    margin-bottom: 0.3em;
}
.show-customer:not(.active):hover {
    background: rgba(0,0,0,.075);
}
.table thead th {
	border-top: none;
}
.table-hover .table-active > td,.table-hover:hover .table-active > td {
    background: #007bff;
    color: white;
}
a, .order-listing, .show-customer, .show-outstanding {
	cursor: pointer;
}
.prev:before {
	content: "\2190 ";
}

.next:before {
	content: "\2192 ";
}
.scroll{
	max-height: calc(100vh - 210px);
	overflow-y: scroll;
}
</style>
<script src="/js/hideseek.min.js"></script>
<script>
$(document).ready(function() {
    startHideSeek();
    setupSearchHandlers();
    setupClickHandlers();

    var customerCode = getParameterFromURL('customer');
    var orderCode = getParameterFromURL('order');

    if (customerCode) {
        clickCustomerLink(customerCode, function() {
            if (orderCode) {
                clickOrderLink(orderCode);
            }
        });
    } else if (orderCode) {
        clickOrderLink(orderCode);
    }
});

function setupSearchHandlers() {
    $('#customer-search').hideseek({
        throttle: 300,
        ignore: '.ignore',
    });
    updateCount();
}

function setupClickHandlers() {
    $('body').on('click', '.order-listing', function() {
        order($(this).data('order'));
        $('tr.table-active').removeClass('table-active');
        $(this).addClass('table-active');
    });

    $(".show-customer").click(function() {
        customer($(this).data('customer'));
        $('.customers .active').removeClass('active');
        $(this).addClass('active');
    });

    $(".show-outstanding").click(function() {
        outstanding();
        $('.customers .active').removeClass('active');
        $(this).addClass('active');
    });
}

function updateCount() {
    $('#count').html($('.table').find('.list > tr:visible').length);
}

$(document).on('ajaxComplete.updateCount', function() {
    updateCount();
});

function getParameterFromURL(key) {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(key);
}

function clickCustomerLink(customerCode, callback) {
    var customerLink = $('.show-customer[data-customer="' + customerCode + '"]');
    if (customerLink.length) {
        customerLink[0].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'start' });
        customerLink.click();
        $(document).one('ajaxComplete.customerLink', function() {
            callback();
            $(document).off('ajaxComplete.customerLink');
        });
    } else {
        console.log('Customer with code ' + customerCode + ' not found.');
    }
}

function clickOrderLink(orderCode) {
    var orderLink = $('.order-listing[data-order="' + orderCode + '"]');
    if (orderLink.length) {
        orderLink[0].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'start' });
        orderLink.click();
    } else {
        console.log('Order with code ' + orderCode + ' not found.');
    }
}

var startHideSeek = function() {
	$('#list-search').hideseek({
		throttle: 300,
	});
	$('#list-search').on("_after_each", function() {
		$( '#count' ).html( $('.table').find('.list > tr:visible').length );
	});
}
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
			$('.xedit').editable();
			// $('.xedit').editable();
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
			startHideSeek();
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
			$('#orderlist').html(data);
			$('button', this).button();
			startHideSeek();
		}
	});
}
</script>
