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
				smart: true,

			},
			// stateSave: true,
			pagingType: "simple_numbers",
			lengthMenu: [10,25,50,100,500,1500],
			columns: [
			{data: "customerCode", searchable: true,
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<a href='view/"+oData.customerCode+"' data-instant>"+oData.customerCode+"</a>");
			}},
			{data: "name", searchable: true,
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<a href='view/"+oData.customerCode+"' data-instant>"+oData.name+"</a>");
			}},
			{data: "phone", searchable: true,
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<a href='tel:"+oData.phone+"' class='tel-link')>"+oData.phone+"</a>");
			}},
			{data: "fax", searchable: false, class: "hidden-xs d-none d-md-table-cell"},
			{data: "status", searchable: true, class: "hidden-xs d-none d-md-table-cell",
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<span class='badge badge-"+oData.style+"'>"+oData.status+"</span>");
			}},
			],
		});
	});
	$('div.dataTables_filter input').select();
	$('div.dataTables_filter input').attr('autocorrect', 'off');
});
