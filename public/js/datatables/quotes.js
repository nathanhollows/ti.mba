$(document).ready(function() {
    var source = $('.dataTable').attr("data-source");
    var state = $('.dataTable').attr("data-state");
    var aTable = $('.dataTable').DataTable({
        serverSide: true,
        ajax: {
            url: source,
            method: 'POST'
        },
        search: {
            smart: true
        },
        // saveState: true,
        paging_type: "simple_numbers",
        lengthMenu: [10,25,50,100,500,1000],
        order: [0, 'desc'],
        dom: 'l<"toolbar">frtip',
        columns: [
            {data: "quoteId",
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<a href='view/"+oData.quoteId+"'>"+oData.quoteId+"</a>");
                }},
            {data: "date"},
            {data: "customerName"},
            {data: "reference"},
            {data: "name"},
            {data: "attention"},
            {data: "statusName", class: "hidden-xs",
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<span class='label label-"+oData.style+"'>"+oData.statusName+"</span>");
                }},
        ]
    });
    $('div.toolbar').html( $('div#filter-list').html() );
    $('div#filter-list').remove();
    $('button.filter-user').on( 'click', function () {
        aTable.column( 4 ).search( $(this).data('user')  ).draw();
    } );
    $('button.filter-status').on( 'click', function () {
        aTable.column( 6 ).search( $(this).data('status')  ).draw();
    } );
    $('div.dataTables_filter input').select();

    $('div.dataTables_filter input').attr('autocorrect', 'off');
});
