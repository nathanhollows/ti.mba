<div class="row">
    <div class="col-md-12">
        <div class="error-template text-center">
            <h1>
                Oops!</h1>
            <h2>
                404 Not Found</h2>
            <div class="error-details">
                Sorry, an error has occured, Requested page not found!
            </div>

            <div class="error-actions">
                {{ link_to('', '<span class="glyphicon glyphicon-home"></span> Take Me Home', 'class': 'btn btn-primary btn-lg' )}}

                {{ link_to('contact', '<span class="glyphicon glyphicon-envelope"></span> Contact', 'class': 'btn btn-default btn-lg' )}}
            </div>
        </div>
    </div>
</div>