$("a[data-target=#modal-ajax]").click(function(ev) {
    ev.preventDefault();
    var target = $(this).attr("href");

    // load the url and show modal on success
    $("#modal-ajax .modal-content").load(target, function() { 
         $("#modal-ajax").modal("show"); 
    });
});