if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|BB10|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
} else {
    $(function() {
        $(".tel-link").each(function(){
            this.href = this.href.replace('tel:', 'DialFromUCA://');
        });
    });
    $('.datatable').on( 'draw.dt', function () {
        $(function() {
            $(".tel-link").each(function(){
                this.href = this.href.replace('tel:', 'DialFromUCA://');
            });
        });
    } );
    $( document ).ajaxComplete(function() {
        $(function() {
            $(".tel-link").each(function(){
                this.href = this.href.replace('tel:', 'DialFromUCA://');
            });
        });
    });
}
