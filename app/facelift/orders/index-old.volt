</div>
<div class="container">
<div class="row hidden-md hidden-lg">
    <div class="col-xs-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <h4>
                    This only works on desktops
                </h4>
            </div>
        </div>
    </div>
</div>
<div class="row hidden-xs hidden-sm">
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Outstanding Orders (<span id="count"></span>)</h3>
            </div>
            <div class="panel-body">
                <input id="list-search" name="search" data-toggle="hideseek" placeholder="Search..." type="text" data-list=".list" class="form-control" accesskey="s" autocomplete="off" autofocus="true">
            </div>
            <div class="panel-body">
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
                        <tr data-order="{{ order.orderNumber }}">
                            <td>
                                <a class="ajax-link" data-order="{{ order.orderNumber }}">{{ order.orderNumber }}</a>
                                <span hidden>{{ order.rep }}</span>
                            </td>
                            {% if order.customerCode is null %}
                            <td></td>
                            {% else %}
                            <td>{% if order.customer %}{{ order.customer.name}}{% endif %}<br>
                                {{ order.customerRef }}</td>
                                {% endif %}
                                <td>{{ date("M d", strtotime(order.date)) }} <br>
                                    {% if order.eta %}{{ date("M d", strtotime(order.eta)) }} {% endif %}</td>
                                    <td>
                                        <p>
                                            {% if order.scheduled is 1 %}
                                            <span class="label label-success">Scheduled</span>
                                            {% elseif order.followUp is 1 %}
                                            <span class="label label-warning">Follow Up</span>
                                            {% endif %}
                                        </p>
                                        <p>{% if order.location %} <span class="label">{{ order.whereabouts.name }}</span> {% endif %}</p>
                                    </td>
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"  id="order-details">
                {{ flashSession.output() }}
                {{ content() }}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Orders
                        {{ link_to('orders/import', 'Sync Orders', 'class': 'a btn btn-warning pull-right') }}
                    </h3>
                    </div>
                    <div class="panel-body">
                        <dl class="dl-horizontal">
                          <dt>Search</dt>
                          <dd><kbd>alt + s</kbd></dd>
                          <dt>Next Order</dt>
                          <dd><kbd>down arrow</kbd></dd>
                          <dt>Previous Order</dt>
                          <dd><kbd>up arrow</kbd></dd>
                          <dt>ETA</dt>
                          <dd><kbd>alt + t</kbd></dd>
                          <dt>Location</dt>
                          <dd><kbd>alt + l</kbd></dd>
                          <dt>Notes</dt>
                          <dd><kbd>alt + n</kbd></dd>
                        </dl>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Orders by Location</h3>
                    </div>
                    <div class="panel-body">
                        <dl class="dl-horizontal">
                            {% for location in countLocations %}
                            <dt>
                                {{ location.location }}
                            </dt>
                            <dd>
                                {{ location.total }}
                            </dd>
                            {% endfor %}
                            <dt>Total Orders</dt>
                            <dd><strong>{{ orders|length }}</strong></dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style media="screen">
        .ajax-link {
            cursor: hand;
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
            color: white;
        }
        div#order-details {
            position: fixed;
            left: 50%;
            width: 31%;
            min-width: 488px;
            max-width: 585px;
        }
    </style>
    <script>

    $( document ).ready( function() {
        $( '#count' ).html( $('.table').find('.list > tr:visible').length );
        $('#list-search').on("_after_each", function() {
            $( '#count' ).html( $('.table').find('.list > tr:visible').length );
        });
        $("a.ajax-link").click(function() {
            fn( $( this ).data('order'));
            $('tr.active').removeClass('active');
            $(this).parents().eq(1).addClass('active');
        });
    });

    var xhr;
    var fn = function(id)
    {
        if(xhr && xhr.readyState != 4){
            xhr.abort();
        }
        xhr = $.ajax({

            type: "GET",
            url: '/orders/view/' +id,
            success: function(data) {
                // data is ur summary
                $('#order-details').html(data);
                $('.xedit').editable();
                $('button', this).button();
            }
        });
    }
    $( document ).ajaxComplete(function() {
        $(".toggle-status").click(function(){
            var target = $(this);
            var oldContent = $(this).html();
            $(this).html('<i class="fa fa-refresh fa-spin"></i>');
            var pk = $(this).data("order");
            var name = $(this).data("name");
            jQuery.ajax({
                type: "POST",
                url: "/orders/update",
                data: { 'pk': pk , 'name': name},
                dataType: 'json',
                cache: false,
                success: function (data) {
                    target.html('<i class="fa fa-check"></i>');
                },
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
        $( 'tr.active' ).removeClass('active').nextAll('tr:visible:first').addClass('active');
        if (!$( 'tr.active' ).data('order')) {
            $('.list tr:visible:first ').addClass('active');
            fn( $( 'tr.active' ).data('order'));
        } else {
            fn( $( 'tr.active' ).data('order'));

        }
    }else if(e.which === 38){
        $( 'tr.active' ).removeClass('active').prevAll('tr:visible:first').addClass('active');
        if (!$( 'tr.active' ).data('order')) {
            $('.list tr:visible:last ').addClass('active');
            fn( $( 'tr.active' ).data('order'));
        } else {
            fn( $( 'tr.active' ).data('order'));
        }
    }
});
    </script>
