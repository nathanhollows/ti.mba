{{ content() }}

<h1>{{ company.name }} | Customer Details</h1>
<hr>
<table style="width: 100%">
	<tbody>
	{% for address in company.addresses %}
		<tr>
			<th>{{ address.type.typeDescription }}</th>
			<td>{{ address.line1 }}</td>
			<td>{{ address.line2 }}</td>
			<td>{{ address.line3 }}</td>
			<td>{{ address.city }}</td>
		</tr>
	{% endfor %}
	</tbody>
</table>

<hr>

<table style="width: 100%">
	<tbody>
		<tr>
			<th>Area</th>
			<td>{{ company.area }}</td>
			<th>Location Sorting</th>
			<td>{{ company.tripDay }}</td>
		</tr>
		<tr>
			<th>Agent</th>
			<td>{{ company.rep.name }}</td>
			<th>Status</th>
			<td>{{ company.status.name }}</td>
		</tr>
		<tr>
			<th>Rank</th>
			<td>{{ company.rank }}</td>
			<th></th>
			<td></td>
		</tr>
	</tbody>
</table>

<hr>

<table style="width: 100%">
	<tbody>
		<tr>
			<th>Phone</th>
			<td>{{ company.phone }}</td>
			<th>Email</th>
			<td>{{ company.email }}</td>
		</tr>
		<tr>
			<th>Phone 2</th>
			<td>{{ company.phone2 }}</td>
			<th>Fax</th>
			<td>{{ company.fax }}</td>
		</tr>
	</tbody>
</table>

<hr>

<table style="width: 100%;">
	<thead>
		<tr>
			<th>Name</th>
			<th>Phone</th>
			<th>Email</th>
			<th>Position</th>
		</tr>
	</thead>
	<tbody>
		{% for contact in company.contacts %}
			<tr>
				<td>{{ contact.name }}</td>
				<td>{{ contact.directDial }}</td>
				<td>{{ contact.email }}</td>
				<td>{{ contact.position }}</td>
			</tr>
		{% endfor %}
	</tbody>
</table>
<br>
<hr>

{{ company.otherContacts|nl2br }}

<footer></footer>

<style type="text/css">
/* http://meyerweb.com/eric/tools/css/reset/
   v2.0 | 20110126
   License: none (public domain) */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed,
figure, figcaption, footer, header, hgroup,
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline; }

/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure,
footer, header, hgroup, menu, nav, section {
  display: block; }

body {
  line-height: 1; }

ol, ul {
  list-style: none; }

blockquote, q {
  quotes: none; }

blockquote:before, blockquote:after,
q:before, q:after {
  content: '';
  content: none; }

table {
  border-collapse: collapse;
  border-spacing: 0;
  /* Here's the real stuff */ }

#page-container {
  padding: 20px;
  margin-top: 20px;
  margin-bottom: 20px; }

#header {
  padding: 5px 20px 5px 20px;
  border-bottom: 1px solid black;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%; }

#footer {
  padding: 5px 20px 5px 20px;
  border-top: 1px solid black;
  position: fixed;
  bottom: 0;
  left: 0px;
  width: 100%; }

body {
  font-size: 10px;
  font-family: Helvetica, sans-serif; }

h1 {
  font-size: 24.41px; }

h2 {
  font-size: 19.53px; }

h3 {
  font-size: 15.63px; }

h4 {
  font-size: 12.5px; }

h5 {
  font-size: 10px; }

h6 {
  font-size: 8px; }

hr {
	margin: 10px 0 10px 0;
}

p {
  padding: 10px 0 10px 0; }

/* Tables and Jazz */
table {
  width: 100%;
  page-break-inside: auto; }

tr, td {
  page-break-inside: avoid;
  page-break-after: auto; }

thead {
  display: table-header-group; }

tfoot {
  display: table-footer-group; }

.striped tr:nth-child(2n) {
  background: #EAEAEA; }

.boxed {
  border: 1px solid black; }

.horizontal-rule tr {
  border-bottom: 1px solid grey; }

tbody tr:hover {
  background: #D8D8D8; }

th {
  font-weight: bold;
  text-align: left; }

td, th {
  padding: 5px; }

thead {
  border-bottom: 1px solid black; }

tfoot {
  border-top: 1px solid black; }

@media print {
    footer {page-break-after: always;}
}
</style>

<script type="text/javascript">
 window.onload = function() { window.print(); }
</script>
