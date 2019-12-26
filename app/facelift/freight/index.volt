{{ content() }}
<div class="row">
    <div class="col-lg-6 col-lg-offset-3">
        <h3>Freight Following</h3>
        {{ flashSession.output() }}
        <ul class="list-group">
            {% set recent = false %}
            {% set delayed = false %}

            {% for item in outstanding %}

            {% if strtotime(item.date) < strtotime('Today - 1 Week') and delayed is false %}
            {% set delayed = true %}
        </ul>
        <h4>Delayed freight</h4>
        <ul class="list-group">
            {% endif %}

            {% if strtotime(item.date) > strtotime('Today - 1 week') and recent is false %}
            {% set recent = true %}
        </ul>
        <h4>Recent</h4>
        <ul class="list-group">
            {% endif %}
            <li class="list-group-item" id="{{ item.docketNo }}">
                {% if "Mainfreight" in item.carrier %}
                <a href="https://www.mainfreight.com/Track/MSNZS/{{ item.carrierLabel }}" target="_blank" title="Track and Trace">{{ item.conNote }} <i 
class="fa fa-icon fa-external-link"></i></a>
                {% else %}
                <a href="http://www.pbt.co.nz/nick/results.cfm?ticketNo={{ item.conNote }}" target="_blank" title="Track and Trace">{{ item.conNote }} <i 
class="fa fa-icon fa-external-link"></i></a>
                {% endif %}
                {% if item.order %}
                {{ item.order.orderNumber }}
                {% if item.order.customer %}
                {{ item.order.customer.customerName }}
                {% endif %}
                {% endif %}
                <span class="pull-right">
                    {% if item.status %}
                        {% if item.red > 1 %}
                            <span class="label label-danger" title="Status has not changed in {{ item.red }} days">{{ item.status }}</span>
                        {% elseif "Received" in item.status %}
                            <span class="label" title="Consignment not loaded into Mainchain">{{ item.status }}</span>
                        {% else %}
                            <span class="label label-info" title="Picked up an in transit">{{ item.status }}</span>
                        {% endif %}
                    {% endif %}
                    <span>{{ date("dS M", strtotime(item.date)) }}</span>
                    {% if item.emailed is 1 %}
                    <a class="sent"><i class="fa fa-icon fa-envelope"></i></a>
                    {% elseif "Mainfreight" in item.carrier %}
                    <a class="mail" href="/freight/mail/mainfreight/{{ item.conNote }}" data-connote="{{ item.conNote }}" title="Email Customer 
Service"><i class="fa fa-icon fa-envelope"></i></a>
                    {% elseif "Peter" in item.carrier %}
                    <a class="mail" href="/freight/mail/pbt/{{ item.conNote }}" data-connote="{{ item.conNote }}" title="Email Customer Service"><i 
class="fa fa-icon fa-envelope"></i></a>
                    {% endif %}
                    <a class="delivered" data-docket="{{ item.docketNo }}"><i class="fa fa-icon fa-check" title="Mark as Delivered"></i></a>
                </span>
            </li>
            {% endfor %}
        </ul>
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
