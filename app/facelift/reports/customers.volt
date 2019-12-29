{{ content() }}
{{ flashSession.output() }}
<table class="table table-hover table-condensed" id="customers">
  <thead>
    <tr>
      <th>Use</th>
      <th>Code</th>
      <th>Name</th>
      <th>Location</th>
      <th>Trip Day</th>
      <th>Rep</th>
      <th>Status</th>
  </tr>
</thead>
<form action="/return" method="POST" role="form" target="_blank">
  <tbody>
    {% for customer in customers %}
    <tr>
      <td><input type="checkbox" class="check" name="customerCode[]" value="{{ customer.customerCode }}"></td>
      <td>{{ customer.customerCode }}</td>
      <td>{{ link_to('customers/view/' ~ customer.customerCode, customer.customerName) }}</td>
      <td>{{ customer.salesArea.name }}</td>
      <td>{{ customer.tripDay }}</td>
			<td>{% if customer.salesArea.rep %}{{ customer.salesArea.rep.name }}{% endif %}</td>
      <td>{{ customer.status.name }}</td>
  </tr>
  {% endfor %}
</tbody>
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <input type="date" name="date" id="date" class="form-control pull-right" value="{{ date("Y-m-d", strtotime("- 6 month")) }}" title="" style="width: auto;">
    <hr>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="btn-group">
            <button type="button" class="btn btn-default" id="select-all">Select Visible</button>
            <button type="button" class="btn btn-default" id="deselect-all">Deselect All</button>
        </div>
        <div class="btn-group pull-right">
            <button type="submit" formaction="/reports/telesales" class="btn btn-info">Telesales List</button>
            <button type="submit" formaction="/reports/customerdetails" class="btn btn-info">Contact Details</button>
            <button type="submit" formaction="/reports/customerhistory" class="btn btn-info">Customer History</button>
        </div>
    <hr>
    </div>
</div>
</form>
<tfoot>
  <tr>
     <th>Use</th>
     <th>Code</th>
     <th>Name</th>
     <th>Location</th>
     <th>Trip Day</th>
     <th>Rep</th>
     <th>Status</th>
 </tr>
</tfoot>
</table>

<script type="text/javascript">
    $(document).ready(function() {
        $('#customers tbody').on( 'click', 'tr', function () {
            $(':checkbox', this).trigger('click');
        });
        $('#customers').ddTableFilter();
        $("#select-all").click(function(){  //"select all" change
            var status = true; // "select all" checked status
            $('.check:visible').each(function(){ //iterate all listed checkbox items
                this.checked = status; //change ".checkbox" checked status
            });
        });
        $("#deselect-all").click(function(){  //"select all" change
            var status = false; // "select all" checked status
            $('.check').each(function(){ //iterate all listed checkbox items
                this.checked = status; //change ".checkbox" checked status
            });
        });
    });
    (function($) {

        $.fn.ddTableFilter = function(options) {
          options = $.extend(true, $.fn.ddTableFilter.defaultOptions, options);

          return this.each(function() {
            if($(this).hasClass('ddtf-processed')) {
              refreshFilters(this);
              return;
          }
          var table = $(this);
          var start = new Date();

          $('th:visible', table).each(function(index) {
              if($(this).hasClass('skip-filter')) return;
              var selectbox = $('<select>');
              var values = [];
              var opts = [];
              selectbox.append('<option value="--all--">' + $(this).text() + '</option>');

              var col = $('tr:not(.skip-filter) td:nth-child(' + (index + 1) + ')', table).each(function() {
                var cellVal = options.valueCallback.apply(this);
                if(cellVal.length == 0) {
                  cellVal = '--empty--';
              }
              $(this).attr('ddtf-value', cellVal);

              if($.inArray(cellVal, values) === -1) {
                  var cellText = options.textCallback.apply(this);
                  if(cellText.length == 0) {cellText = options.emptyText;}
                  values.push(cellVal);
                  opts.push({val:cellVal, text:cellText});
              }
          });
              if(opts.length < options.minOptions){
                return;
            }
            if(options.sortOpt) {
                opts.sort(options.sortOptCallback);
            }
            $.each(opts, function() {
                $(selectbox).append('<option value="' + this.val + '">' + this.text + '</option>')
            });

            $(this).wrapInner('<div style="display:none">');
            $(this).append(selectbox);

            selectbox.bind('change', {column:col}, function(event) {
                var changeStart = new Date();
                var value = $(this).val();

                event.data.column.each(function() {
                  if($(this).attr('ddtf-value') === value || value == '--all--') {
                    $(this).removeClass('ddtf-filtered');
                }
                else {
                    $(this).addClass('ddtf-filtered');
                }
            });
                var changeStop = new Date();
                if(options.debug) {
                  console.log('Search: ' + (changeStop.getTime() - changeStart.getTime()) + 'ms');
              }
              refreshFilters(table);

          });
            table.addClass('ddtf-processed');
            if($.isFunction(options.afterBuild)) {
                options.afterBuild.apply(table);
            }
        });

          function refreshFilters(table) {
              var refreshStart = new Date();
              $('tr', table).each(function() {
                var row = $(this);
                if($('td.ddtf-filtered', row).length > 0) {
                  options.transition.hide.apply(row, options.transition.options);
              }
              else {
                  options.transition.show.apply(row, options.transition.options);
              }
          });

              if($.isFunction(options.afterFilter)) {
                options.afterFilter.apply(table);
            }

            if(options.debug) {
                var refreshEnd = new Date();
                console.log('Refresh: ' + (refreshEnd.getTime() - refreshStart.getTime()) + 'ms');
            }
        }

        if(options.debug) {
          var stop = new Date();
          console.log('Build: ' + (stop.getTime() - start.getTime()) + 'ms');
      }
  });
      };

      $.fn.ddTableFilter.defaultOptions = {
          valueCallback:function() {
            return encodeURIComponent($.trim($(this).text()));
        },
        textCallback:function() {
            return $.trim($(this).text());
        },
        sortOptCallback: function(a, b) {
            return a.text.toLowerCase() > b.text.toLowerCase();
        },
        afterFilter: null,
        afterBuild: null,
        transition: {
            hide:$.fn.hide,
            show:$.fn.show,
            options: []
        },
        emptyText:'--Empty--',
        sortOpt:true,
        debug:false,
        minOptions:2
    }

})(jQuery);
</script>
