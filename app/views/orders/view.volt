		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><span data-toggle="collapse" data-target="#order-info">Order {{ order.orderNumber }}</span>
				<span class="pull-right">
					<button type="button" data-order="{{ order.orderNumber }}" data-name="followUp" class="toggle-status btn btn-{% if order.followUp is 1 %}warning{% else %}default{% endif %}">Follow Up</button>
					<button type="button" data-order="{{ order.orderNumber }}" data-name="scheduled" class="toggle-status btn btn-{% if order.complete is 0 and order.scheduled is 1 %}success{% else %}default{% endif %}">Scheduled</button>
					<button type="button" data-order="{{ order.orderNumber }}" data-name="completed" class="toggle-status btn btn-{% if order.complete is 1 %}danger{% else %}default{% endif %}">Complete</button>
				</span>
				</h3>
			</div>
			<div class="panel-body collapse fade in" id="order-info">
                <dl class="dl-horizontal">
                    <dt>Customer</dt>
                    <dd>
                        {% if order.customer %}
                            <strong>{{ link_to('customers/view/' ~ order.customerCode|lower , order.customer.name) }}</strong>
                        {% else %}
                            <em>None</em>
                        {% endif %}
                    </dd>
                    <dt>Reference</dt>
                    <dd>{{ order.customerRef }}</dd>
                    <dt>Rep</dt>
                    <dd>
                        {{ order.rep }}
                    </dd>
                    <dt>Date</dt>
                    <dd>{{ order.date ~ " - about " ~ order.date|timeAgoDate }}</dd>
                    <dt>ETA</dt>
                    <dd><a href="#" id="eta" data-type="date" data-pk="{{ order.orderNumber }}" data-url="/orders/update/" data-title="ETA" data-placement="bottom" class="xedit" accesskey="t">{{ order.eta }}</a>
					{% if order.eta %} - about {{ order.eta|timeAgoDate }}{% endif %}</dd>
                    <dt>Location</dt>
                    <dd><a href="#" id="location" data-type="select" data-source="[ {% for location in locations %}{value: {{ location.id }}, text: '{{ location.name }}'},{% endfor %} ]" data-pk="{{ order.orderNumber }}" data-value="{{ order.location }}" data-url="/orders/update/" data-title="Location" class="xedit" data-placement="bottom" data-autoclose="true" accesskey="l">{% if order.location %}{{ order.whereabouts.name }}{% endif %}</a></dd>
                    <dt>Notes</dt>
                    <dd>{{ order.description }}</dd>
                    <dt>Dispatcher Notes</dt>
                    <dd><a href="#" id="notes" data-type="textarea" data-pk="{{ order.orderNumber }}" data-url="/orders/update/" data-title="Notes" data-mode="inline" class="xedit" style="white-space: pre-line;" accesskey="n">{{ order.notes }}</a></dd>
                </dl>
			</div>
            {% if order.followUp %}
            <div class="panel-footer note">
                <strong style="display: block; width: 100%; text-align: center;">{{ order.followUpReason }}</strong>
            </div>
            {% endif %}
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Items</h3>
			</div>
				<ul class="list-group">
				{% for item in order.items %}
					<li class="list-group-item {% if item.complete is 1 %}complete{% endif %}">
                        {% if item.grade === "FREIGHT" or item.grade === "CREDIT" or item.grade === "SETUP" %}
                        <strong>{{ item.itemNo }}.</strong>
                        {{ item.grade|lower|capitalize }}
                        <span class="pull-right">${{ item.price }}</span>
                        {% continue %}
                        {% endif %}
						{% if item.despatch %}
						    <span class="label label-success pull-right">Scheduled</span>
						{% endif %}
                        {% if item.complete is 1 %}
                            <span class="label label-info pull-right">Complete</span>
                        {% endif %}
						<strong>{{ item.itemNo }}.</strong>
						{{ item.width }} x {{ item.thickness }}
						{{ item.grade }}
						{{ item.treatment }}
						{{ item.dryness }}
						{{ item.finish }}
                        <em>{{ item.notes }}</em><br>
                        {% if item.complete is 1 %}
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            {% if item.tallies %}
                            {% for tally in item.tallies %}
                            {{ tally.pieces }}/{{ number_format(tally.length,1) }}
                            {% endfor %}
                            {% endif %}
                            <code>
                                {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
                            </code>
                        {% else %}
						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            {% if item.tallies %}
                            {% for tally in item.tallies %}
                            {{ tally.pieces }}/{{ number_format(tally.length,1) }}
                            {% endfor %}
                            {% endif %}
                            <code>
                                {{ item.sent|number }}/{{ item.ordered|number }} {{ item.unit }}
                            </code>
                        {% endif %}
                        <span class="pull-right">${{ item.price }}</span>
					</li>
				{% endfor %}
				</ul>
		</div>
        {% if order.dockets|length > 0 %}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Delivery</h3>
            </div>
            <div class="panel-body">
                {% for docket in order.dockets %}
                    {% if docket.carrier is defined %}
    				{% if "Mainfreight" in docket.carrier %}
    				    <a href="https://www.mainfreight.com/Track/MSNZS/{{ docket.carrierLabel }}" target="_blank" title="Track and Trace">{{ docket.conNote }} <i class="fa fa-icon fa-external-link"></i></a>
    				{% elseif "peter" in docket.carrier|lower %}
    				    <a href="http://www.pbt.co.nz/nick/results.cfm?ticketNo={{ docket.conNote }}" target="_blank" title="Track and Trace">{{ docket.conNote }} <i class="fa fa-icon fa-external-link"></i></a>
    				{% else %} 
                        {{ docket.conNote }} 
                    {% endif %}
                    {% else %}
                        {{ docket.conNote }} 
                    {% endif %}
                    Sent {{ docket.date|timeAgoDate }} on {{ docket.carrier }}
                    {% if docket.delivered is 0 %}
						{% if docket.status %}
	                        {% if docket.red > 2 %}
	                            <span class="label label-danger pull-right" title="Status has not changed in {{ docket.red }} days">{{ docket.status }}</span>
	                        {% elseif "Received" in docket.status %}
	                            <span class="label pull-right" title="Consignment loaded but not picked up">{{ docket.status }}</span>
	                        {% else %}
	                            <span class="label label-info pull-right" title="Picked up an in transit">{{ docket.status }}</span>
	                        {% endif %}
	                    {% else %}
							<span class="label label-info pull-right">Not Delivered</span>
						{% endif %}
                    {% else %}
                        <span class="pull-right label label-success">Delivered</span>
                    {% endif %}
                    <br />
                {% endfor %}
            </div>
        </div>
        {% endif %}
