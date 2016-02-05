<script type="text/javascript">
    $(document).ready(function() {
        $('.dataTable').each(function () {
        var source = $(this).attr("data-source");
        var state = $(this).attr("data-state");
        $(this).DataTable({
            serverSide: true,
            ajax: {
                url: source,
                method: 'POST'
            },
            search: {
                smart: true
            },
            stateSave: true,
            pagingType: "simple_numbers",
            columns: [
            {data: "customerCode", searchable: true,
            "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                $(nTd).html("<a href='{{ url('customers/view/') }}"+oData.customerCode+"'>"+oData.customerCode+"</a>");
            }},
            {data: "customerName", searchable: true},
            {data: "customerPhone", searchable: true,
            "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                $(nTd).html("<a href='tel:"+oData.customerPhone+"')>"+oData.customerPhone+"</a>");
            }},
            {data: "customerFax", searchable: false, class: "hidden-xs"},
            {data: "name", searchable: true, class: "hidden-xs",
            "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                $(nTd).html("<span class='label label-"+oData.style+"'>"+oData.name+"</span>");
            }},
            ],
        });
        });
    $('div.dataTables_filter input').select();
    $('#enable').click(function() {
        $('.editable').editable('toggleDisabled');
    });   
    $.fn.editable.defaults.mode = 'inline';    
    $('.generaledit').editable();
    $('.editable').editable('toggleDisabled');

    });
</script>