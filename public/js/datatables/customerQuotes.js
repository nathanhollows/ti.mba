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
			pagingType: "full",
			order: [0, 'desc'],
			columns: [
			{data: "quoteId",			
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<a href='/quotes/view/"+oData.quoteId+"'>"+oData.quoteId+"</a>");
			}},
			{data: "date"},
			{data: "reference"},
			{data: "user",
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html(""+oData.salesRep+"");
			}},
			{data: "attention"},
			{data: "status", class: "hidden-xs",
			"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
				$(nTd).html("<span class='label label-"+oData.style+"'>"+oData.name+"</span>");
			}}
			]
		});
	});
});
