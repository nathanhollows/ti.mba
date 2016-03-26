$(document).ready(function() {
    	$( ".select2, .select2-multiple" ).select2( {  } );
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
				$(nTd).html("<a href='view/"+oData.customerCode+"'>"+oData.customerCode+"</a>");
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
	$("a[data-target=#modal-ajax]").click(function(ev) {
		ev.preventDefault();
		var target = $(this).attr("href");

    // load the url and show modal on success
    $.fn.modal.Constructor.prototype.enforceFocus = function() {
    	$( ".select2, .select2-multiple" ).select2( {  } );
    	$("#details").markdown({ })
    };
    $("#modal-ajax .modal-content").load(target, function() { 
    	$("#modal-ajax").modal("show"); 
    });
});
});
var data = {
  // A labels array that can contain any sort of values
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri','Mon', 'Tue', 'Wed', 'Thu', 'Fri','Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  // Our series array that contains series objects or in this case series data arrays
  series: [
    [5, 2, 4, 2, 0,2,5, 2, 4, 2, 0,2,5, 2, 4]
  ]
};

// Create a new line chart object where as first parameter we pass in a selector
// that is resolving to our chart container element. The Second parameter
// is the actual data object.
new Chartist.Line('.ct-chart', data);