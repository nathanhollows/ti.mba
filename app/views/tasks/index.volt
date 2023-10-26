{{ content() }}

<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-7 ">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Follow Ups</h3>
            </div>
            <div class="panel-body">
                <table class="table" id="tasks">
                    <thead>
                        <tr>
                            <th>
                                Customer
                            </th>
                            <th>
                                Reference
                            </th>
                            <th>
                                Status
                            </th>
                            <th>
                                Type
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for task in overdue %}
                        <tr data-id="{{ task.id }}">
                            <td>
                                {{ task.company.name }}
                            </td>
                            <td>
                                <a class="ajax-link" data-id="{{ task.id }}">{% if task.reference %}{{ task.reference }}{% else %}<code>No reference</code>{% endif %}</a>
                            </td>
                            <td>
                                <span class="label label-danger">Overdue</span>
                            </td>
                            <td>
                                <span class="label ">{{ task.type.name }}</span>
                            </td>
                        </tr>
                        {% endfor %}
                        {% for task in today %}
                        <tr data-id="{{ task.id }}">
                            <td>
                                {{ task.company.name }}
                            </td>
                            <td>
                                <a class="ajax-link" data-id="{{ task.id }}">{% if task.reference %}{{ task.reference }}{% else %}<code>No reference</code>{% endif %}</a>
                            </td>
                            <td>
                                <span class="label label-primary">Today</span>
                            </td>
                            <td>
                                <span class="label ">{{ task.type.name }}</span>
                            </td>
                        </tr>
                        {% endfor %}
                        {% for task in coming %}
                        <tr data-id="{{ task.id }}">
                            <td>
                                {{ task.company.name }}
                            </td>
                            <td>
                                <a class="ajax-link" data-id="{{ task.id }}">{% if task.reference %}{{ task.reference }}{% else %}<code>No reference</code>{% endif %}</a>
                            </td>
                            <td>
                                <span class="label">Later</span>
                            </td>
                            <td>
                                <span class="label ">{{ task.type.name }}</span>
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-5" id="contact-details">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Follow Up Details</h3>
            </div>
            <div class="panel-body">
                <p>
                    Click on a reference to get started.
                </p>
                <label for="dynamic_select">View a users follow ups</label>
                <div class="form-group">
                    <select id="dynamic_select" class="form-control">
                        {% for user in users %}
                        <option value="{{ static_url('/tasks/user/' ~ user.id) }}" {% if user.id === id %}selected="true"{% endif %}>{{  user.name }}</option>
                        {% endfor %}
                    </select>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    oTable = $('#tasks').DataTable( {
        "paging":   false,
        "ordering": true,
        "info":     false,
        "search": 	false,
        "order": [[2, "desc"]]
    } );
    $('#datatable-search').keyup(function(){
        oTable.search($(this).val()).draw() ;
    });
    jQuery(document).ready(function($) {
        $(".clickable-row").click(function() {
            window.document.location = $(this).data("href");
        });
    });
} );
$( document ).ready( function() {
    $("a.ajax-link").click(function() {
        fn( $( this ).data('id'));
        $('tr.active').removeClass('active');
        $(this).parents().eq(1).addClass('active');
    });
});


var xhr;
var fn = function(id)
{
    if(xhr && xhr.readyState != 4){
        xhr.abort();
    }
    xhr = $.ajax({
        type: "GET",
        url: '/tasks/view/' +id,
        success: function(data) {
            // data is ur summary
            $('#contact-details').html(data);
            $('.xedit').editable();
        }
    });
}
$(window).keydown(function(e){
    if($("input,textarea,select").is(":focus")){
        return;
    }else if(e.which === 40){
        e.preventDefault();
        $( 'tr.active' ).removeClass('active').nextAll('tr:visible:first').addClass('active');
        if (!$( 'tr.active' ).data('id')) {
            $('#tasks tbody tr:visible:first ').addClass('active');
            fn( $( 'tr.active' ).data('id'));
        } else {
            fn( $( 'tr.active' ).data('id'));

        }
    }else if(e.which === 38){
        e.preventDefault();
        $( 'tr.active' ).removeClass('active').prevAll('tr:visible:first').addClass('active');
        if (!$( 'tr.active' ).data('id')) {
            $('#tasks tbody tr:visible:last ').addClass('active');
            fn( $( 'tr.active' ).data('id'));
        } else {
            fn( $( 'tr.active' ).data('id'));
        }
    }
});
$( document ).ajaxComplete(function() {
    $(".toggle-status").click(function(){
        var target = $(this);
        var oldContent = $(this).html();
        jQuery.ajax({
            type: "POST",
            url: "/followup/ajaxcomplete/" + $( this ).data('record'),
            cache: false,
            success: function (data) {
                target.toggleClass('btn-success');
                target.html('Updated!');
            },
            error: function (data) {
                target.toggleClass('btn-danger');
                target.html('Something went wrong!');
            }
        });
    });
});
</script>
<style media="screen">
a.ajax-link {
    cursor: hand;
}
span.editable-container.editable-inline, .control-group.form-group, .editable-input, textarea.form-control.input-large {
    width: 100%;
    float: left;
    clear: right;
}
.editable-buttons {
    float: left;
    margin-top: 10px;
}
span#date {    
    background: #fff9b9;
    border-bottom: 1px dashed #f6bb42;
}
span#details {
    display: block;
    background: #fff9b9;
    border-bottom: 1px dashed #f6bb42;
    padding: 7px 13px;
    border-radius: 3px;
}
</style>

<script type="text/javascript">
 $(function(){
  // bind change event to select
  $('#dynamic_select').on('change', function () {
      var url = $(this).val(); // get selected value
      if (url) { // require a URL
          window.location = url; // redirect
        }
        return false;
      });
	});
</script>
