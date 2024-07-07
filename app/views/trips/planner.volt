<form action="/return" method="POST" role="form" target="_blank">
    <div class="header py-3">
        <div class="container">
            <div class="row header-body">
                <div class="col">
                    <h4 class="header-title">Trip planner</h4>
                </div>
                <div class="col text-right">
                      <div class="btn-group" role="group">
                        <button id="modal-trigger" type="button" class="btn btn-primary" data-toggle="modal" data-target="#saveTripModal">
                            Save trip
                        </button>
                        <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Saved Trips
                        </button>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1">
                        {% for trip in trips %}
                        <a class="dropdown-item" href="/trips/view/{{ trip.niceName }}">{{ trip.name }}</a>
                        {% endfor %}
                        {% if trips|length == 0 %}
                        <span class="dropdown-item" href="#">No saved trips</span>
                        {% endif %}
                        </div>
                    </div>
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
                    <button type="button" class="btn btn-secondary btn-outline" id="deselect-all" disabled>
                        <span class="feather">
                            {{ emicon('square') }}
                        </span>
                        Deselect All
                    </button>
                </div>
                <div class="btn-group float-right">
                    <button type="submit" formaction="/reports/customerdetails" class="btn btn-primary"
                        id="contact-details" disabled>
                        {{ emicon('printer') }}
                        Print details
                    </button>
                </div>
            </div>
        </div>
        <table class="table table-hover dataTable bg-white" id="customers">
            <thead>
                <tr>
                    <th class="skip-filter">Select</th>
                    <th class="skip-filter">Code</th>
                    <th class="skip-filter">Name</th>
                    <th>Area</th>
                    <th>Rep</th>
                    <th class="skip-filter">Status</th>
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
                        {% if customer.salesArea is defined %}
                        {{ customer.salesArea }}
                        {% else %}
                        <span class="xedit" data-name="area" data-type="select" data-pk="{{ customer.customerCode}}"
                            data-url="/customers/ajaxupdate" data-placement="auto" data-title="Area"
                            data-value="{{ customer.salesArea }}"></span>
                        {% endif %}
                    </td>
                    <td>
                        {% if customer.salesRep is defined %}
                        {{ customer.salesRep }}
                        {% else %}
                        <span class="badge badge-secondary">Not set</span>
                        {% endif %}
                    </td>
                    <td>
                        <span class="badge badge-{{ customer.style }}">{{ customer.status }}</span>
                    </td>
                </tr>
                {% endfor %}
                {% for customer in incomplete %}
                <tr>
                    <td><input type="checkbox" class="check" name="customerCode[]" value="{{ customer.customerCode }}">
                    </td>
                    <td>{{ customer.customerCode }}</td>
                    <td>{{ link_to('customers/view/' ~ customer.customerCode, customer.name) }}</td>
                    <td>
                        {% if customer.salesArea is defined %}
                        {{ customer.salesArea }}
                        {% else %}
                        <span class="xedit" data-name="area" data-type="select" data-pk="{{ customer.customerCode}}"
                            data-url="/customers/ajaxupdate" data-placement="auto" data-title="Area"
                            data-value="{{ customer.salesArea }}"></span>
                        {% endif %}
                    </td>
                    <td>
                        {% if customer.salesRep is defined %}
                        {{ customer.salesRep }}
                        {% else %}
                        <span class="badge badge-secondary">Not set</span>
                        {% endif %}
                    </td>
                    <td>
                        <span class="badge badge-{{ customer.style }}">{{ customer.status }}</span>
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

<form action="/trips/save" method="POST" role="form">
    <div class="modal fade" id="saveTripModal" tabindex="-1" role="dialog" aria-labelledby="save-trip-modal-title" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="save-trip-modal-title">Create a new trip</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="tripName" class="form-label">Trip name</label>
                        <input type="text" class="form-control" id="tripName" name="name" placeholder="Auckland: Day 2" list="regions-list" autocomplete="off" required>
                        <datalist id="regions-list">
                            {% for area in salesAreas %}
                            <option value="{{ area.area }}: Day #">{{ area.area }}</option>
                            {% endfor %}
                        </datalist>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            Selected Customers
                        </label>
                        <ul id="selected-customers-list" class="list-group"></ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button id="save-trip" type="submit" class="btn btn-primary">Save trip</button>
                </div>
            </div>
        </div>
    </div>
</form>

<script src="/js/sortable.1.15.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {

    // Event listener for checkbox state change
    $('#customers').on('change', '.check', function () {
        updateButtonStates();
    });

    // Event delegation for row click
    $('#customers').on('click', 'tbody tr', function (event) {
        // Prevent checkbox click event from bubbling
        event.stopPropagation();
        // Don't do anything if a span or link was clicked
        if ($(event.target).is('span') || $(event.target).is('a') || $(event.target).is('div') || $(event.target).is('select')) return;
        // Prevent triggering twice for the checkbox
        if (event.target.type !== 'checkbox') {
            $(':checkbox', this).trigger('click');
        }
    });

    // Simple 'select all' behavior
    $("#select-all").click(function () {
        $('.check:visible').prop('checked', true);
        updateButtonStates();
    });

    // Simple 'deselect all' behavior
    $("#deselect-all").click(function () {
        $('.check').prop('checked', false);
        updateButtonStates();
    });

    // Function to update the state of the buttons
    function updateButtonStates() {
        const anyChecked = $('.check:checked').length > 0;
        $('#deselect-all').prop('disabled', !anyChecked);
        $('#contact-details').prop('disabled', !anyChecked);
        $('#modal-trigger').prop('disabled', !anyChecked);
        $('#save-trip').prop('disabled', !anyChecked);
    }

    // Initialize the custom table filter plugin
    $('#customers').ddTableFilter();

    // Update the selected customers list in the modal
    $('#modal-trigger').click(function () {
        var selectedCustomers = $('.check:checked').closest('tr').map(function () {
            return {
                code: $('td:nth-child(2)', this).text(),
                name: $('td:nth-child(3)', this).text()
            };
        }).get();
        var $list = $('#selected-customers-list').empty();
        $.each(selectedCustomers, function (index, customer) {
            $list.append('<li class="list-group-item" data-customer-code="' + customer.code + '">' +
                customer.name + '<button type="button" class="close remove-customer" aria-label="Close">' +
                '<input type="hidden" name="customerCode[]" value="' + customer.code + '">' +
                '<span aria-hidden="true">&times;</span></button></li>');
        });
        Sortable.create($list[0], {
            animation: 150
        });
        setTimeout(() => $('#tripName').focus(), 500);
    });

    // Handle removal of customers from the list
    $('#selected-customers-list').on('click', '.remove-customer', function () {
        var $item = $(this).closest('li');
        var customerCode = $item.data('customer-code');
        // Uncheck the corresponding checkbox in the table
        $('input.check[value="' + customerCode + '"]').prop('checked', false);
        $item.remove();
        updateButtonStates();
    });


});

(function ($) {
    'use strict';

    // Main function for the ddTableFilter plugin
    $.fn.ddTableFilter = function (options) {
        // Extend default options with those provided
        options = $.extend(true, $.fn.ddTableFilter.defaultOptions, options);

        // Process each matched element
        return this.each(function () {
            var table = $(this);

            // If table has been processed, refresh filters and exit
            if (table.hasClass('ddtf-processed')) {
                refreshFilters(table);
                return;
            }

            var start = new Date(); // For debug timing

            // Process each visible header in the table
            $('th:visible', table).each(function (index) {
                if ($(this).hasClass('skip-filter')) return;

                var selectbox = $('<select class="form-control">');
                var values = [];
                var opts = [];
                selectbox.append('<option value="--all--">' + $(this).text() + '</option>');

                // Get unique filter values and labels for this column
                var col = $('tr:not(.skip-filter) td:nth-child(' + (index + 1) + ')', table).each(function () {
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
                        opts.push({ val: cellVal, text: cellText });
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
                $.each(opts, function () {
                    selectbox.append('<option value="' + this.val + '">' + this.text + '</option>');
                });

                // Replace header content with selectbox
                $(this).wrapInner('<div style="display:none">').append(selectbox);

                // Bind the change event handler
                selectbox.bind('change', { column: col }, function (event) {
                    var value = $(this).val();

                    event.data.column.each(function () {
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
                $('tr', table).each(function () {
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
        valueCallback: function () {
            return encodeURIComponent($.trim($(this).text()));
        },
        textCallback: function () {
            return $.trim($(this).text());
        },
        sortOptCallback: function (a, b) {
            return a.text.toLowerCase() > b.text.toLowerCase();
        },
        afterFilter: null,
        afterBuild: null,
        transition: {
            hide: $.fn.hide,
            show: $.fn.show,
            options: []
        },
        emptyText: ' Not Set',
        sortOpt: true,
        debug: false,
        minOptions: 2
    };

})(jQuery);

$(document).ready(function () {
    var salesareas = [
        // Volt
        {% for area in salesAreas %}
            { "value": "{{ area.id }}", "text": "{{ area.area }}", "rep": "{{ area.rep}}" },
        {% endfor %}
    ]; // Define your roles here
    $.fn.editable.defaults.mode = 'inline';
    $('.xedit').editable({
        source: function () {
            return salesareas;
        },
        // Set the nearest badge to the matching rep name from the salesareas array
        success: function (response, newValue) {
            // Get the text of the selected option
            var text = salesareas.find(x => x.value === newValue).text;
            // Update the parent td ddtf-value attribute encoded for url
            var safeValue = encodeURIComponent(text);
            $(this).parent().attr('ddtf-value', safeValue);

            // Update the neighbouring td with the rep name and new ddtf-value
            var rep = salesareas.find(x => x.value === newValue).rep;
            var safeRep = encodeURIComponent(rep);
            $(this).parent().next().text(rep);
            $(this).parent().next().attr('ddtf-value', safeRep);

        }
    });
});

// A function to call "/address/geocode/{customerCode}" 
function geocodeCustomer(customerCode) {
    $.ajax({
        url: '/address/geocode/' + customerCode,
        type: 'GET',
        success: function (response) {
            console.log(response);
        },
        error: function (response) {
            console.error(response);
        }
    });
}

// Geocode every customer in the table
// Send 10 requests a second to avoid rate limiting
function geocodeAllCustomers() {
    var customers = [];
    $('#customers tbody tr').each(function () {
        customers.push($(this).find('td:nth-child(2)').text());
    });
    var i = 0;
    var interval = setInterval(function () {
        if (i < customers.length) {
            geocodeCustomer(customers[i]);
            i++;
        } else {
            clearInterval(interval);
        }
    }, 100);
}

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
    .list-group-item {
        cursor: move;
    }
    .btn:disabled {
        cursor: not-allowed;
    }
</style>