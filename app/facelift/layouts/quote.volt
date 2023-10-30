<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Your Page Title</title>
  <link href='https://fonts.googleapis.com/css?family=Rokkitt' rel='stylesheet' type='text/css'>
  <style type="text/css">
    /* http://meyerweb.com/eric/tools/css/reset/
    v2.0 | 20110127
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
      border: 0;
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
      font-size: 1em;
    }
    
    p {
      font-size: 1em;
      color: #757578;
    }
    
    h1 {
      font-family: 'Rokkitt', serif;
      font-size: 4em;
    }
    h2 {
      font-family: 'Rokkitt', serif;
      font-size: 3em;
      color: rgb(89, 89, 89);
    }
    h3 {
      font-size: 1em;
      line-height: 3em;
      margin: 1em 0 1em 0;
    }
    h4 {
      font-size: 1.5em;
      letter-spacing: 0.05em;
      text-transform: uppercase;
    }
    h5 {
      font-size: 1em;
    }
    h6 {
      font-size: 1em;
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
      background: #000000;
      color: white;
      font-weight: bold;
      text-align: center;
    }
    
    table {
      width: 100%;
    }
    
    table, tr, td, th, tbody, thead, tfoot {
      padding: 3mm;
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
      width: 9em;
      display: block;
      float: left;
      clear: both;
    }
    
    #client p, #supplier p {
      font-size: 1em;
    }
    
    #parties span {
      clear: both;
      display: block;
    }

    #ref {
      font-family: 'Rokkitt', serif;
      font-weight: bold;
    }
    
    #subheader {
      clear: both;
      display: block;
    }
    
    hr {
      background: #BABABB;
      border: none;
      display: block;
      width: 100%;
      height: 0.7mm;
      margin-bottom: 2em;
    }

    tr#freight {
      background: #383838;
    }
    
    tr#lead {
      background: #535353;
    }
    
    tr#validity {
      background: #7c7c7c;
    }
    
    strong {
      font-weight: bold;
    }
    
    p strong {
      color: black;
      
    }
    
    #notes {
      margin-top: 5mm;
    }

    .right {
      text-align: right;
    }

    .left {
      text-align: left;
    }
    
    span.rightalign {
      width: 16%;
      display: inline-block;
    }
    span.page {
      padding: 0;
    }
    
  #header {
    font-family: 'Rokkitt', serif;
    color: white;
    font-size: 1em;
    background-color: black;
    margin-bottom: 6mm;
    width: 100%; 
    padding: 6.5mm 0 4mm 15mm;
  }
  #header h1 {
    color: white;
    font-size: 1.5em;
    letter-spacing: 0.05em;
    padding: 9.5mm; font-weight: 700;
  }
  body {
    font-size: 1em;
  }
</style>
</head>
<body>
  {{ content() }}
</body>
</html>