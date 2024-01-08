<form class="form-inline">
    <div class="form-group">
        <label class="sr-only" for="width">Width</label>
        <input type="number" class="form-control size" id="width" placeholder="Width" data-column="1" autofocus="true">
    </div>
    <div class="form-group ml-1">
        <label class="sr-only" for="thickness">Thickness</label>
        <input type="number" class="form-control size" id="thickness" placeholder="Thickness" data-column="2">
    </div>
    <div class="btn-group ml-1" role="group">
        <button type="button" class="btn btn-info filter-offsite" data-offsite="0">Onsite</button>
        <button type="button" class="btn btn-default filter-offsite" data-offsite="1">Offsite</button>
    </div>
    <button type="button" class="btn btn-danger ml-1" id="clear">Clear Filters</button>
</form>
<table id="stock" class="table table-striped table-bordered" cellspacing="0" width="100%">
    <thead>
        <td>Packet</td>
        <td>Width</td>
        <td>Thickness</td>
        <td>Grade</td>
        <td>Treatment</td>
        <td>Dryness</td>
        <td>Finish</td>
        <td>Lineal</td>
        <td>Cube</td>
    </thead>
</table>

<script type="text/javascript">
$(document).ready(function() {
    var table = $('#stock').DataTable({
        serverSide: true,
        ajax: {
            url: '{{ url('m/stock/search') }}',
            method: 'POST'
        },
        stateSave: true,
        search: {
            smart: true,
        },
        // stateSave: true,
        pagingType: "simple_numbers",
        lengthMenu: [10,25,50,100,500,1500],
        columns: [
            {data: "packetNo", searchable: true,
            "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                $(nTd).html("<a href='/m/packets/view/"+oData.packetNo+"'>"+oData.packetNo+"</a>");
            }},
            {data: "width", searchable: true},
            {data: "thickness", searchable: true},
            {data: "grade", searchable: true},
            {data: "treatment", searchable: true},
            {data: "dryness", searchable: true},
            {data: "finish", searchable: true},
            {data: "linealTally", searchable: true},
            {data: "netCube", searchable: true},
            {data: "offsite", searchable: true, visible: false},
        ],
    });
    table.column( 12 ).search(1).draw();
    // Filter event handler
    $('.size').keyup(function() {
        table
        .column($(this).data('column'))
        .search(this.value)
        .draw()
    });
    $('.filter-finish').on( 'click', function () {
      table.column( 10 ).search( $(this).data('finish')  ).draw();
      $(".filter-finish").removeClass('btn-info').addClass('btn-default');
      $(this).removeClass('btn-default').addClass('btn-info');
    });
    $('.filter-offsite').on( 'click', function () {
      table.column( 11 ).search( $(this).data('offsite')  ).draw();
      $(".filter-offsite").removeClass('btn-info').addClass('btn-default');
      $(this).removeClass('btn-default').addClass('btn-info');
    });
    $('#clear').on( 'click', function () {
        $(".form-inline input").val('');
        $(".btn-info").removeClass('btn-info').addClass('btn-default');
      table.search('').columns().search('').draw();
    });
    $('#stock tbody').on( 'click', 'tr', function () {
        $("#data").text(( JSON.stringify(table.rows().row().data()) ));
    } );
} );
</script>

<style type="text/css">
input {
    max-width: 170px;
}
.row:first-of-type {
    display: none;
}
</style>
