<div id="header">
	<img src="/img/logo.png" height="80mm"
		style="vertical-align: middle; float: left; margin-top: 1em; margin-right: 2em;">
	<h1>
		The easiest timber company <br>
		to deal with in New Zealand
	</h1>
</div>

<div class="page">
	<div id="quote-details">
		<span id="ref">
			<h1 style="display: inline-block;">
				<strong>Quote: {{ quote.quoteId }} &nbsp;</strong>
			</h1>
			<h2 style="display: inline-block;">
				{% if quote.reference is not empty %}
				Ref: {{ quote.reference }}
				{% endif %}
			</h2>
		</span>
		<span id="subheader">
			<p>
				<strong>Date:</strong>
				{{ date('d F Y', dated) }}
				<br>
				<br>
			</p>
		</span>
	</div>
	<hr>
	<div id="parties">
		<div id="client">
			<h4><strong>{{ quote.customer.name }} </strong></h4>
			<p>
				{% if quote.customerContact %} 
				<span><strong>Attn:</strong> {{quote.customerContact.name }}</span>
				{% endif %}
				<span><strong>Address:</strong>
				{% for address in quote.customer.addresses %}
					{% if address.type.typeCode is 6 %}
						{% if address.line2 %}
							{{ address.line2 }}
						{% endif %}
						{% if address.line3 %}
							{% if address.line2 and address.line3 %}
								<br>
								<strong>&nbsp;</strong>
							{% endif %}
							{{ address.line3 }}
						{% endif %}
						{% if address.city or address.zipCode or address.country %}
							<br>
							<strong>&nbsp;</strong>
							{% if address.city %}
								{{ address.city }}
							{% endif %}
							{% if address.zipCode %}
								{{ address.zipCode }}
							{% endif %}
							{% if address.country %}
								{{ address.country }}
							{% endif %}
						{% endif %}
					{% endif %}
				{% endfor %}</span>
			</p>
		</div>
		<div id="supplier">
			<h4><strong>ATS TIMBER LIMITED</strong></h4>
			<p>
				<strong>Prepared by:</strong> {{quote.rep.name }} <br>
				<strong>Email:</strong> {{ quote.rep.email }}<br>
				<strong>Phone:</strong>
				{% if quote.rep.directDial %}
					{{ quote.rep.directDial }}<br>
				{% else %}
					0508 22 77 22<br>
				{% endif %}
				<strong>Fax:</strong>0508 22 77 11<br>
			</p>
		</div>
	</div>
	<div id="particulars">
		<table>
			<thead>
				<tr>
					<th>Item</th>
					<th class="left">Description</th>
					<th>Finish Size</th>
					<th class="right">Qty</th>
					<th class="right">Price</th>
				</tr>
			</thead>
			<tbody>
			{% for item in items %}
				<tr>
					<td class="item"> {{ loop.index }} </td>
					<td>
						{% if item.gra.name is not empty %}
							{{ item.gra.name }}&nbsp;
						{% endif %}
						{% if item.treat.name is not empty %}
							{{ item.treat.name }}&nbsp;
						{% endif %}
						{% if item.dry.name  is not empty %}
							{{ item.dry.name }}&nbsp;
						{% endif %}
						{% if item.fin.name is not empty %}
							{{ item.fin.name }}&nbsp;
						{% endif %}
						<br>
						<span class="deets">{{ item.lengths }}</span>
					</td>
					<td class="description">
						{% if item.width > 0 and item.thickness > 0 %}
						{{ item.width }} x {{ item.thickness }}
						{% endif %}
					</td>
					<td class="qty">{{ item.qty }} {% if item.qty is not null %}{{ item.unit.name }}{% else %}-{% endif %}</td>
					<td class="price">{{ item.price|money }} {{ item.unit.name }}</td>
				</tr>
			{% endfor %}
			</tbody>
		</table>
		<table>
			<tfoot>
			{% if quote.freight is not empty %}
				<tr id="freight">
					<td><strong>Freight Charge</strong>
					<span class="rightalign">${{ quote.freight }}</span></td>
				</tr>
			{% endif %}
			{% if quote.leadTime is not empty %}
				<tr id="lead">
					<td><strong>Approx. Lead Time</strong>
					<span class="rightalign">{{ quote.leadTime }}</span></td>
				</tr>
			{% endif %}
				<tr id="validity">
					<td><strong>Price Valid For</strong>
					{% if quote.validity is not empty %}
						<span class="rightalign">{{ quote.validity }} days</span></td>
					{% else %}
						<span class="rightalign">30 days</span></td>
					{% endif %}
				</tr>
			</tfoot>
		</table>
	</div>
	<div id="notes">
	{% if quote.notes %}
		<h4><strong>SPECIAL NOTES</strong></h4>
		<ul>
			{{ quote.notes }}
		</ul>
	{% endif %}
	<h5><strong>ADDITIONAL NOTES</strong></h5>
		<p style="padding-bottom: 0px;"><small>
		All prices exclude GST. All products are random length up to 6.0m unless specified otherwise.
		Priced as a job lot. Any variations will be subject to a requote. Lead times are approximate
		and subject to change. Prices are net only and exclude any allowance for preferred supplier
		rebates, retenetions or other financial implications. Users of ATS Timber Products should rely
		on their own professional judgement and skill in determining appropriateness of product
		choices and design for NZ Building Code compliant systems.
		</small></p>
	</div>
</div>
     </body>
 </html>
