<form action="/return" method="POST" role="form" target="_blank">
    <div class="header py-3">
        <div class="container">
            <div class="row header-body">
                <div class="col">
                    <h4 class="header-title">Trip planner</h4>
                </div>
                <div class="col text-right">
                    <div class="m-2 d-inline-block">
                        Show records since:
                    </div>
                    <input type="date" name="date" id="date" class="form-control float-right"
                        value="{{ date("Y-m-d", strtotime("- 6 month")) }}" title="" style="width: auto;">
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col">
                {{ content() }}
                {{ flashSession.output() }}
                {{ flash.output() }}
            </div>
        </div>
    </div>

    <div class="container bg-white py-3 mb-4 border shadow-sm rounded">
        <div class="row">
            <div class="col py-3">
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary btn-outline" id="select-all">
                        <span class="feather">
                            {{ emicon('copy-check') }}
                            </span>
                        Select Visible
                    </button>
                    <button type="button" class="btn btn-secondary btn-outline" id="deselect-all">
                        <span class="feather">
                            {{ emicon('square') }}
                            </span>
                        Deselect All
                    </button>
                </div>
                <div class="btn-group float-right">
                    <button type="submit" formaction="/reports/telesales" class="btn btn-primary">Telesales
                        List</button>
                    <button type="submit" formaction="/reports/customerdetails" class="btn btn-primary">
                        Contact Details
                    </button>
                    <button type="submit" formaction="/reports/customerhistory" class="btn btn-primary">Customer
                        History</button>
                </div>
            </div>
        </div>
        <table class="table table-hover dataTable bg-white" id="customers">
            <thead>
                <tr>
                    <th>Select</th>
                    <th class="skip-filter">Code</th>
                    <th class="skip-filter">Name</th>
                    <th>Area</th>
                    <th>Rep</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                {% for customer in customers %}
                <tr>
                    <td><input type="checkbox" class="check" name="customerCode[]" value="{{ customer.customerCode }}">
                    </td>
                    <td>{{ customer.customerCode }}</td>
                    <td>{{ link_to('customers/view/' ~ customer.customerCode, customer.name) }}</td>
                    <td>
                        {% if customer.salesarea.name is defined %}
                        {{ customer.salesarea.name }}
                        {% else %}
                        <span class="badge badge-secondary">Not set</span>
                        {% endif %}
                    </td>
                    <td>
                        {% if customer.salesarea.rep.name is defined %}
                        {{ customer.salesarea.rep.name }}
                        {% else %}
                        <span class="badge badge-secondary">Not set</span>
                        {% endif %}
                    </td>
                    <td>
                        <span class="badge badge-{{ customer.state.style }}">{{ customer.state.name }}</span>
                    </td>
                </tr>
                {% endfor %}
            </tbody>
            <tfoot>
                <tr>
                    <th>Select</th>
                    <th>Code</th>
                    <th>Name</th>
                    <th>Area</th>
                    <th>Rep</th>
                    <th>Status</th>
                </tr>
            </tfoot>
        </table>
    </div>
</form>

<script type="text/javascript">
    $(document).ready(function() {
        // Using event delegation for better performance on dynamic content
        $('#customers').on('click', 'tbody tr', function(event) {
            // Prevent triggering twice for the checkbox
            if (event.target.type !== 'checkbox') {
                $(':checkbox', this).trigger('click');
            }
        });
        
        // Simplified 'select all' behavior
        $("#select-all").click(function() {
            $('.check:visible').prop('checked', true);
        });
        
        // Simplified 'deselect all' behavior
        $("#deselect-all").click(function() {
            $('.check').prop('checked', false);
        });
        
        // Initialize the custom table filter plugin
        $('#customers').ddTableFilter();
    });

    (function($) {
    'use strict';

    // Main function for the ddTableFilter plugin
    $.fn.ddTableFilter = function(options) {
        // Extend default options with those provided
        options = $.extend(true, $.fn.ddTableFilter.defaultOptions, options);

        // Process each matched element
        return this.each(function() {
            var table = $(this);

            // If table has been processed, refresh filters and exit
            if (table.hasClass('ddtf-processed')) {
                refreshFilters(table);
                return;
            }

            var start = new Date(); // For debug timing

            // Process each visible header in the table
            $('th:visible', table).each(function(index) {
                if ($(this).hasClass('skip-filter')) return;

                var selectbox = $('<select class="form-control">');
                var values = [];
                var opts = [];
                selectbox.append('<option value="--all--">' + $(this).text() + '</option>');

                // Get unique filter values and labels for this column
                var col = $('tr:not(.skip-filter) td:nth-child(' + (index + 1) + ')', table).each(function() {
                    var cellVal = options.valueCallback.apply(this);
                    if (cellVal.length === 0) {
                        cellVal = '--empty--';
                    }
                    $(this).attr('ddtf-value', cellVal);

                    if ($.inArray(cellVal, values) === -1) {
                        var cellText = options.textCallback.apply(this);
                        if (cellText.length === 0) {
                            cellText = options.emptyText;
                        }
                        values.push(cellVal);
                        opts.push({val: cellVal, text: cellText});
                    }
                });

                // If not enough options, skip the filter for this column
                if (opts.length < options.minOptions) {
                    return;
                }

                // Sort options if required
                if (options.sortOpt) {
                    opts.sort(options.sortOptCallback);
                }

                // Add options to selectbox
                $.each(opts, function() {
                    selectbox.append('<option value="' + this.val + '">' + this.text + '</option>');
                });

                // Replace header content with selectbox
                $(this).wrapInner('<div style="display:none">').append(selectbox);

                // Bind the change event handler
                selectbox.bind('change', {column: col}, function(event) {
                    var value = $(this).val();

                    event.data.column.each(function() {
                        if ($(this).attr('ddtf-value') === value || value === '--all--') {
                            $(this).removeClass('ddtf-filtered');
                        } else {
                            $(this).addClass('ddtf-filtered');
                        }
                    });

                    refreshFilters(table);
                });

                table.addClass('ddtf-processed');

                if ($.isFunction(options.afterBuild)) {
                    options.afterBuild.apply(table);
                }
            });

            // Refresh function to show/hide rows based on filter selections
            function refreshFilters(table) {
                $('tr', table).each(function() {
                    var row = $(this);
                    if ($('td.ddtf-filtered', row).length > 0) {
                        options.transition.hide.apply(row, options.transition.options);
                    } else {
                        options.transition.show.apply(row, options.transition.options);
                    }
                });

                if ($.isFunction(options.afterFilter)) {
                    options.afterFilter.apply(table);
                }

                if (options.debug) {
                    var refreshEnd = new Date();
                    console.log('Refresh: ' + (refreshEnd.getTime() - start.getTime()) + 'ms');
                }
            }

            if (options.debug) {
                var stop = new Date();
                console.log('Build: ' + (stop.getTime() - start.getTime()) + 'ms');
            }
        });
    };

    // Default options for ddTableFilter plugin
    $.fn.ddTableFilter.defaultOptions = {
        valueCallback: function() {
            return encodeURIComponent($.trim($(this).text()));
        },
        textCallback: function() {
            return $.trim($(this).text());
        },
        sortOptCallback: function(a, b) {
            return a.text.toLowerCase() > b.text.toLowerCase();
        },
        afterFilter: null,
        afterBuild: null,
        transition: {
            hide: $.fn.hide,
            show: $.fn.show,
            options: []
        },
        emptyText: '--Empty--',
        sortOpt: true,
        debug: false,
        minOptions: 2
    };

})(jQuery);

</script>
        
<style>
    table select {
        font-weight: bold !important;
    }
    .feather svg {
        width: 1em;
    }
    thead {
        position: sticky;
        top: 0;
        background-color: #fff;
    }
</style>