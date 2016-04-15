$(document).ready(function() {
    	$( ".select2, .select2-multiple" ).select2( {  } );
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