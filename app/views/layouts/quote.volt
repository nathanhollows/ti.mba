<!DOCTYPE HTML>
<style type="text/css">
	/* http://meyerweb.com/eric/tools/css/reset/
   v2.0 | 20110126
   License: none (public domain)
   */
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
    font-family:
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
    margin: 5mm 0 5mm 0;
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
  }

  body {
    font-family: Verdana, Geneva, sans-serif;
    font-style: normal;
    font-variant: normal;
    font-weight: 500;
    font-size: 3mm;
  }

  p {
    font-size: 15mm;
    color: #757578;
  }

  h1 {
    font-size: 3em;
    color: #084727;
  }
  h2 {
    font-size: 3.3em;
    color: #084727;
    float: left;
  }
  h3 {
    font-size: 2.5em;
    color: #636366;
    line-height: 2.5em;
  }
  h4 {
    font-size: 1.5em;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    color: #231F20;
  }
  h5 {
    font-size: 1em;
    color: #084727;
  }
  h6 {
    font-size: 1em;
    color: #084727;
  }
  p {
    font-size: 1em;
    margin: 5mm 0 5mm 0;
  }

  #client {
    width: 46%;
    float: left;
    padding-right: 4%;
  }

  #supplier {
    width: 50%;
    float: left;
  }

  th {
    min-height: 6mm;
    background: #646466;
    color: white;
    font-weight: bold;
    text-align: center;
  }

  table {
   width: 100%;
 }

 table, tr, td, th, tbody, thead, tfoot {
  padding: 3mm;
  font-size: 3.2mm;
}

tr, tbody, thead, tfoot {
  page-break-inside: avoid !important;
}

td.item {
  text-align: center;
  width: 4%;
}

span.deets {
  padding-top: 2mm;
  font-style: italic;
  display: block;
}

td.description {
  text-align: center;
  width: 14%;
}

td.qty {
  text-align: right;
  width: 16%;
}

td.price {
  text-align: right;
  width: 16%;
}

tbody tr {
 background: #F6F6F6;
 min-height: 3em;
}

tbody tr:nth-child(2n) {
 background: white;
 border-top: 0.2mm solid #646466;
 border-bottom: 0.2mm solid #646466;
}

tbody tr:nth-last-child(1) {
  border-bottom: none;
}

tfoot {
 text-align: right;
 color: white;
}
.page{
 padding: 0 15mm 0 15mm;
}

#parties {
  clear: both;
}

td.item {
  text-align: center;
  width: 4%;
}

#parties p {
  line-height: 2em;
}

#parties p strong {
  width: 30%;
  display: block;
  float: left;
  clear: both;
}

#client p, #supplier p {
  font-size: 3.2mm;
}

#parties span {
  clear: both;
  display: block;
}

#subheader {
  clear: both;
  display: block;
}

.break {
  background: #BABABB;
  display: block;
  width: 100%;
  height: 0.7mm;
  margin-top: 2mm;
  margin-bottom: 6mm;
}

tr#freight {
 background: #646466;
}

tr#lead {
 background: #0A462A;
}

tr#validity {
 background: #F9961F;
}

strong {
 font-weight: bold;
}

p strong {
  color: #004710;

}

#notes {
  margin-top: 5mm;
}

span.rightalign {
  width: 16%;
  display: inline-block;
}
span.page {
  padding: 0;
}

</style>

{{ content() }}
