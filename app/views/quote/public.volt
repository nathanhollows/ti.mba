<!DOCTYPE html>
<html>
<head>
	<link href='https://fonts.googleapis.com/css?family=Rokkitt' rel='stylesheet' type='text/css'>
	<style type="text/css">
		#header {
			font-family: 'Rokkitt', serif;
			color: white;
			font-size: 7mm;
			background: #084727;
            margin-bottom: 6mm;
		}
        body {
            font-size: 1em;
        }
	</style>
</head>
<body>
	<div id="header" style="width: 100%; border-bottom: 1mm solid orange; padding: 6.5mm 0 6.5mm 15mm;">
		<img src="/img/logo.png" height="80mm" style="vertical-align: middle;">
		<span style="padding: 9mm; font-weight: 700; letter-spacing: 0.26mm">The Timber Innovators</span>
	</div>
 {{ content() }}

<div class="page">
	<div id="quote-details">
		<span id="header"><h2><strong>Quote: {{ quote.quoteId }} &nbsp;</strong>
		</h2>
		<h2>
			{% if quote.reference is not empty %}
				<span style="font-size: 25px;">Ref: {{ quote.reference }}</span>
			{% endif %}
		</h2>
		</span>
		<span id="subheader">
		<h3><strong>Date:</strong> {{ date('d F Y', dated) }}</h3>
	</div>
	<div class="break"></div>
	<div id="parties">
		<div id="client">
			<h4><strong>{{ quote.customer.name }} </strong></h4>
			<p>
				<span><strong>Attn:</strong> {{quote.attention }}
				{% if quote.customerContact %} {{ quote.customerContact.name }} {% endif %}<br></span>
				<span><strong>Address:</strong>
				{% for address in quote.customer.addresses %}
					{% if address.type.typeCode is 2 %}
						{% if address.line2 %}
							{{ address.line2 }},
						{% endif %}
						{% if address.line3 %}
						{% endif %}
						{% if address.city or address.zipCode or address.country %}
							<br>
							<strong>&nbsp;</strong>
							{% if address.city %}
								{{ address.city }},
							{% endif %}
							{% if address.zipCode %}
								{{ address.zipCode }},
							{% endif %}
							{% if address.country %}
								{{ address.country }}
							{% endif %}
						{% endif %}
					{% endif %}
				{% endfor %}</span>
				<span><strong>Ref: </strong> {{quote.reference }}</span>
			</p>
		</div>
		<div id="supplier">
			<h4><strong>ATS TIMBER LIMITED</strong></h4>
			<p>
				<strong>Prepared by:</strong> {{quote.rep.name }} <br>
				<strong>Email:</strong> {{ quote.rep.email }}<br>
				<strong>Phone:</strong> {{ quote.rep.directDial }}<br>
				<strong>Fax:</strong>0508 22 77 11<br>
			</p>
		</div>
	</div>
	<div id="particulars">
		<table>
			<thead>
				<tr>
					<th>Item</th>
					<th>Description</th>
					<th>Finish Size</th>
					<th>Qty</th>
					<th>Price</th>
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
					<td class="price">${{ item.price}} {{ item.unit.name }}</td>
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
					{% if quote.validty is not empty %}
						<span class="rightalign">{{ quote.validity }}</span></td>
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
