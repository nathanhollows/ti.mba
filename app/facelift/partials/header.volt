<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    {{ renderTitle() }}</title>

    <link rel="shortcut icon" href="/favicon.ico?m=1" type="image/x-icon" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap-editable.css"/>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
<style>
.bg-dark {
    background-color: 
    #152b3e !important;
}
.bg-light {
    background-color:
    #f2f1eb !important;
}
.header.bg-dark {
    background-color:
    #1b354a !important;
}
.feather {
	height: 1rem;
	margin-top: -0.2rem;
}

/* Timeline Stytling */

pre {
    font-size: 87.5%;
    color: #212529;
    border-left: 0.3rem solid #f2f1eb;
}
#thetimeline .card p, #thetimeline .card code {
    font-size: 87.5%;
}
li:hover .confirm-delete {
    visibility: visible;
}
li .confirm-delete {
    visibility: hidden;
}

/* Tables */
.table .thead-dark th {
    color: #fff;
    background-color: #2a3e4f;
    border-color: #152b3e;
}

/* Search */

#search-results {
	display: none;
	position: absolute;
	z-index: 2;
	top: 2.7em;
	right: 1em;
	left: 0;
	z-index: 3;
}

.xedit {
	margin-bottom: -1px;
	border-bottom: 1px dashed;
	color: var(--dark);
}
.editable-empty {
    color: #c62d3b;
}
</style>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
  </head>
  <body class="mb-5 bg-light" data-instant-whitelist>
