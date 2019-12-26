$(document).ready(function() {
    $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    });
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
            $('.xedit').editable();
        });
    });
    $('.xedit').editable();
    $('#enable').click(function() {
        $('.xedit').editable('toggleDisabled');
    });

    // Javascript to enable link to tab
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href="#'+url.split('#')[1]+'"]').tab('show') ;
    }

    // With HTML5 history API, we can easily prevent scrolling!
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        if(history.pushState) {
            history.pushState(null, null, e.target.hash);
        } else {
            window.location.hash = e.target.hash; //Polyfill for old browsers
        }
    })

});
