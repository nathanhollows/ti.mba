<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    {{ get_title() }}</title>

    <!-- Bootstrap Core CSS -->
    
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.5/paper/bootstrap.min.css" rel="stylesheet" integrity="sha256-hMIwZV8FylgKjXnmRI2YY0HLnozYr7Cuo1JvRtzmPWs= sha512-k+wW4K+gHODPy/0gaAMUNmCItIunOZ+PeLW7iZwkDZH/wMaTrSJTt7zK6TGy6p+rnDBghAxdvu1LX2Ohg0ypDw==" crossorigin="anonymous">
    <!-- Custom CSS -->
    <link href="{{ static_url( "css/app.css" ) }}" rel="stylesheet">


    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#customers').DataTable({
                serverSide: true,
                ajax: {
                    url: '/avaunt/customers/test',
                    method: 'POST'
                },
                stateSave: true,
                columns: [
                {data: "customerCode", searchable: true,
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<a href='/avaunt/customers/view/"+oData.customerCode+"'>"+oData.customerCode+"</a>");
                }},
                {data: "customerName", searchable: true},
                {data: "customerPhone"},
                {data: "customerFax", searchable: false},
                ],
            });
        });
    </script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
  </head>
  <body>