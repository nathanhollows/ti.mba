<h3>Telemarketing list</h3>

<table class="table table-condensed horizontal-rule">
  <thead>
    <tr>
      <th>Customer</th>
      <th>Names</th>
      <th>Manager</th>
      <th>Phone</th>
      <th>Time</th>
    </tr>
  </thead>
  <tbody>
    {% for customer in customers %}
    <tr id="{{customer.customerCode}}">
      <td>{{ customer.name }}</td>
      <td>
        {% for contact in customer.contacts %}
        {{ contact.name }}, 
        {% endfor %}
      </td>
      <td>{{ customer.salesArea.rep.name }}</td>
      <td>{{ customer.phone }}</td>
      <td></td>
    </tr>
    {% endfor %}
  </tbody>
</table>


<style type="text/css">
	body {
		background: white;
	}

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
    vertical-align: baseline; 
  }

  /* HTML5 display-role reset for older browsers */
  article, aside, details, figcaption, figure,
  footer, header, hgroup, menu, nav, section {
    display: block; 
  }

  body {
    line-height: 1; 
  }

  ol, ul {
    list-style: none; 
  }

  blockquote, q {
    quotes: none; 
  }

  blockquote:before, blockquote:after,
  q:before, q:after {
    content: '';
    content: none; 
  }

  table {
    border-collapse: collapse;
    border-spacing: 0;
  /* Here's the real stuff */ }

  #page-container {
    padding: 20px;
    margin-top: 20px;
    margin-bottom: 20px; 
  }

  #header {
    padding: 5px 20px 5px 20px;
    border-bottom: 1px solid black;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%; 
  }

  #footer {
    padding: 5px 20px 5px 20px;
    border-top: 1px solid black;
    position: fixed;
    bottom: 0;
    left: 0px;
    width: 100%; 
  }

  body {
    font-family: Helvetica, sans-serif; 
  }

  h1 {
    font-size: 24.41px; 
  }

  h2 {
    font-size: 19.53px; 
  }

  h3 {
    font-size: 15.63px; 
  }

  h4 {
    font-size: 12.5px; 
  }

  h5 {
    font-size: 10px; 
  }

  h6 {
    font-size: 8px; 
  }

  hr {
   margin: 10px 0 10px 0;
   background: black;
 }

 p {
  padding: 10px 0 10px 0; 
}

/* Tables and Jazz */
table {
  width: 100%;
  page-break-inside: auto; 
}

tr, td {
  page-break-inside: avoid;
  page-break-after: auto; 
}

thead {
  display: table-header-group; 
}

tfoot {
  display: table-footer-group; 
}

.striped tr:nth-child(2n) {
  background: #EAEAEA; 
}

.boxed {
  border: 1px solid black; 
}

.horizontal-rule tr {
  border-bottom: 1px solid black; 
}

th {
  font-weight: bold;
  text-align: left; 
}

td, th {
  padding: 5px; 
}

thead {
  border-bottom: 1px solid black; 
}

tfoot {
  border-top: 1px solid black; 
}

tr.switch.noprint {
  background: #eaeaea;
}


.printonly {
  display: none;
}

.noshow {
  display: none;
}

@media print{
  @page {
    size: landscape
  }
  body {
    font-size: 10px;
    line-height: 1.428;
  }
  footer {page-break-after: always;}
  tr.switch.noprint {
    display: none;
  }
  td {
    padding-bottom: 25px !important;
  }
  .printonly {
    display: visible;
  }

  .noprint {
    display: none;
  }

  .printme {
    display: unset;
  }
  .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
    border-top: 1px solid black;
  }
}

</style>
<script type="text/javascript">
  window.print();
</script>
