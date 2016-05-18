$(document).ready(function() {

  $("a[data-target=#modal-ajax]").click(function(ev) {
    ev.preventDefault();
    var target = $(this).attr("href");

    // load the url and show modal on success
    $.fn.modal.Constructor.prototype.enforceFocus = function() {
      $('.selectpicker').selectpicker('refresh');
      $(".markdown-edit").markdown({ });
    };
    $("#modal-ajax .modal-content").load(target, function() { 
      $("#modal-ajax").modal("show"); 
    });
  });
});