{{ content() }}
{{ flashSession.output() }}
<div class="row collapse" id="help">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Shortcuts</h3>
            </div>
            <div class="panel-body">
                <p>
                    These shortcuts are available for use when creating quotes
                </p>
                <dl class="dl-horizontal">
                    <dt>Next Cell</dt>
                    <dd><kbd>alt + arrow keys</kbd></dd>
                    <dt>Move</dt>
                    <dd><kbd>alt + shift + up/down</kbd></dd>
                    <dt>Insert</dt>
                    <dd><kbd>alt + enter</kbd></dd>
                    <dt>Duplicate</dt>
                    <dd><kbd>alt + d</kbd></dd>
                    <dt>Delete</dt>
                    <dd><kbd>alt + shift + backspace</kbd></dd>
                </dl>
                <p>
                    Holding <code>shift</code> moves the newly inserted / duplicated line above the current one. <code>Move</code> and <code>Delete</code> only apply to unsaved lines.
                </p>
            </div>
        </div>
    </div>
</div>
<div class="row row-flex row-flex-wrap">
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
        <div class="panel panel-primary flex-panel">
            <div class="panel-heading">
                <h3 class="panel-title">Quote Details
                    <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('quotes/edit/' ~ quote.quoteId) }}' data-target="#modal-ajax"><i class="fa fa-pencil"></i> Edit</a>
                </h3>
            </div>
            <div class="panel-body">
                <span class="quote-deets"><strong>Status: </strong></span>
                <span class="label label-{{ quote.genericStatus.style }}">{{ quote.genericStatus.statusName }}</span>

                <div class="clearfix"></div>

                <span class="quote-deets"><strong>Attention: </strong></span>
                <span class="block">{{ quote.attention }} {% if quote.customerContact is not empty %}{{ quote.customerContact.name }} <br>
                    <a href="tel:{{ quote.customerContact.directDial|stripspace }}" class="tel-link">{{ quote.customerContact.directDial }}</a>{% endif %}</span>

                    <div class="clearfix"></div>

                    <span class="quote-deets"><strong>Reference:</strong></span>
                    <a href="#" class="xedit" id="reference" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Reference">{{ quote.reference }}</a><br />

                    <div class="clearfix"></div>

                    <span class="quote-deets"><strong>Date:</strong></span>  <a href="#" class="xedit" id="date" data-type="date" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Date" data-placement="bottom">{{ quote.date }}</a><br>

                    <div class="clearfix"></div>

                    <span class="quote-deets"><strong>Rep:</strong></span>  <a href="#" class="xedit" id="rep" data-type="select" data-source="[ {% for user in users %}{value: {{user.id}}, text: '{{ user.name }}'},{% endfor %} ]" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Sales Rep" data-value="{{ quote.rep.id }}">{{ quote.rep.name }}</a><br>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
            <div class="panel panel-success flex-panel">
                <div class="panel-heading">
                    <h3 class="panel-title">Quote Specifics</h3>
                </div>
                <div class="panel-body" id="specifics">
                    <strong>Lead Time:</strong> 	<span class="pull-right"> <a href="#" class="xedit" id="leadTime" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Lead Time">{{ quote.leadTime }}</a> <br> </span>
                    <div class="clearfix"></div>
                    <strong>Validity:</strong> 	<span class="pull-right"> <a href="#" class="xedit" id="validity" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Vailidity">{{ quote.validity }}</a> days<br>  </span>
                    <div class="clearfix"></div>
                    <strong>Freight:</strong> 	<span class="pull-right"> $<a href="#" class="xedit" id="freight" data-type="text" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Freight">{{ quote.freight }}</a> <br> </span>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
            <div class="panel panel-info flex-panel">
                <div class="panel-heading">
                    <h3 class="panel-title">Notes</h3>
                </div>
                <div class="panel-body">
                    <strong>Quote Notes:</strong><br>
                    <a href="#" class="xedit" id="notes" data-type="textarea" data-mode="inline" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Public Notes">{{ quote.notes }}</a> <br>
                    <strong>Private Notes:</strong><br>
                    <a href="#" class="xedit" id="moreNotes" data-type="textarea" data-mode="inline" data-pk="{{ quote.quoteId }}" data-url="/quotes/ajaxupdate" data-title="Private Notes">{{ quote.moreNotes }}</a> <br>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-12 hidden-sm hidden-xs">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Quote Items
                        <button class="btn pull-right" type="button" data-toggle="collapse" data-target="#help" aria-expanded="false" aria-controls="help">
                            Shortcuts
                        </button>
                    </h3>
                </div>
                <div class="panel-body">
                    <form action="/quotes/saveitems" method="POST" role="form" id="items">
                        <table data-navigable-spy data-editable data-editable-spy class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Grade</th>
                                    <th>Treatment</th>
                                    <th>Dryness</th>
                                    <th>Width</th>
                                    <th>Thick</th>
                                    <th>Finish</th>
                                    <th>Notes</th>
                                    <th>Qty</th>
                                    <th>Unit</th>
                                    <th>Price</th>
                                </tr>
                            </thead>

                            <tbody>
                                {# Loop through the quote items #}

                                {{ hidden_field('quoteId', 'value': quote.quoteId) }}

                                {% for item in items %}
                                <tr class="record">
                                    <td>
                                        {{ hidden_field('id[]', 'value': item.id) }}
                                        {{ select_static('grade[]', grades, 'using': ['shortCode', 'name'], 'value': item.grade, 'class': 'data grade', 'data-live-search': 'true', 'data-container': 'body') }}
                                    </td>
                                    <td>{{ select_static('treatment[]', treatment, 'using': ['shortCode', 'shortCode'], 'value': item.treatment, 'class': 'data treatment' , 'data-live-search': 'true', 'data-container': 'body') }}</td>
                                    <td>{{ select_static('dryness[]', dryness, 'using': ['shortCode', 'shortCode'], 'value': item.dryness, 'class': 'data dryness', 'data-live-search': 'true', 'data-container': 'body') }}</td>
                                    <td>
                                        {{ numeric_field('width[]', 'value': item.width, 'class': 'data width') }}
                                    </td>
                                    <td>
                                        {{ numeric_field('thickness[]', 'value': item.thickness, 'class': 'data thickness') }}
                                    </td>
                                    <td>
                                        {{ select_static('finish[]', finishes, 'using': ['id', 'name'], 'value': item.finish, 'class': 'data') }}
                                    </td>
                                    <td>
                                        {{ text_field('lengths[]', 'value': item.lengths ) }}
                                    </td>
                                    <td>
                                        {{ numeric_field('qty[]', 'value': item.qty, 'step': 'any', 'class': 'qty') }}
                                    </td>
                                    <td>
                                        {{ select_static('priceMethod[]', priceMethod, 'using': ['id', 'name'], 'value': item.priceMethod, 'class': 'data priceMethod') }}
                                    </td>
                                    <td>
                                        {{ numeric_field('unitPrice[]', 'value': item.price, 'step': 'any') }}
                                    </td>
                                    <td>
                                        <a href="#" data-href="/quotes/deleteitem/{{ item.id }}" data-toggle="modal" data-target="#confirm-delete" tabindex="-1" class="text-danger delete"><i class="fa fa-times"></i></a>
                                    </td>
                                </tr>
                                {% endfor %}
                                <tr>
                                    <td>
                                        {{ hidden_field('id[]') }}
                                        {{ form.render('grade[]') }}
                                    </td>
                                    <td>{{ form.render('treatment[]') }}</td>
                                    <td>{{ form.render('dryness[]') }}</td>
                                    <td>
                                        {{ numeric_field('width[]', 'placeholder': 'Width', 'class': 'data width') }}
                                    </td>
                                    <td>
                                        {{ numeric_field('thickness[]', 'placeholder': 'Thickness', 'class': 'data thickness') }}
                                    </td>
                                    <td>
                                        {{ select_static('finish[]', finishes, 'using': ['id', 'name'], 'class': 'data', 'useEmpty': true) }}
                                    </td>
                                </td>
                                <td>
                                    {{ text_field('lengths[]', 'placeholder': 'Notes / Lengths') }}
                                </td>
                                <td>
                                    {{ numeric_field('qty[]', 'step': 'any', 'placeholder': 'Qty', 'class': 'qty') }}
                                </td>
                                <td>
                                    {{ select_static('priceMethod[]', priceMethod, 'using': ['id', 'name'], 'class': 'data priceMethod', 'useEmpty': false) }}
                                </td>
                                <td>
                                    {{ numeric_field('unitPrice[]', 'step': 'any', 'placeholder': 'Price') }}
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>Grade</th>
                                <th>Treatment</th>
                                <th>Dryness</th>
                                <th>Width</th>
                                <th>Thick</th>
                                <th>Finish</th>
                                <th>Notes</th>
                                <th>Qty</th>
                                <th>Unit</th>
                                <th>Price</th>
                            </tr>
                        </tfoot>
                    </table>
                    <button type="submit" class="btn btn-primary">Update</button>
                </form>
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-12 hidden-md hidden-lg">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Item summary</h3>
            </div>
            <div class="panel-body">
                {% for item in quote.items %}
                    <strong>{{ loop.index }}.</strong> {{ item.width }} x {{ item.thickness }} {{ item.grade }} {{ item.treatment }} {{ item.dryness }} {{ item.fin.name }} ${{ item.price }} {{ item.unit.name }}
                    {% if item.lengths %}
                        <br />
                        <i>{{ item.lengths }}</i>
                    {% endif  %}
                    <hr />
                {% endfor %}
            </div>
        </div>
    </div>
</div>

{{ partial('timeline') }}

<style type="text/css">
#rowToClone {
  display: none;
}

#items td {
  padding: 0;
}

.priceMethod {
  min-width: 58px;
}

#items select, #items input {
    width: 100%;
    padding: 8px;
}
#items input[type='number'] {
    max-width: 80px;
}
span.quote-deets {
    width: 90px;
    display: block;
    float: left;
}
span.block {
    display: inline-table;
}
select.data {
    background: transparent;
    border: 0;
}
.record:hover a.delete, .active a.delete {
    visibility: visible;
}

a.delete {
    visibility: hidden;
}

select.data.grade {
    width: 170px;
}
select.data.treatment {
    width: 72px;
}
select.data.dryness {
    width: 54px;
}
</style>
<script type="text/javascript">
$(function() {

    $('form#items').areYouSure( {'message':'Your quote details are not saved!'} );

});
</script>
