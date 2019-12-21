{{ content() }}
</div>
<div class="container-fluid pipeline-container">
<div class="">
<div class="col col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1 col-xs-12">
	{% for category in categories %}
	<div class="category {% if category.jobs|length < 1 %}hidden{% endif %}">
		<ul class="list-group searchable" id="list{{ category.id }}">
			<li class="group-header ingnore-me">
				<h4 class="list-group-item-heading">{{ category.name }}</h4>
				<span class="count"></span> Projects
				<span class="total"></span>
			</li>
			{% for job in category.jobs %}
				<li class="list-group-item item" data-id="{{ job.id }}" data-value="{{ job.value }}">

                <p>
                <big><strong><a href="#" class="xedit" id="title" data-type="text" data-placement="bottom" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Job Title">{{ job.title }}</a></strong></big>
                <strong class="pull-right">
                        $<a href="#" class="xedit" id="value" data-type="number" data-placement="bottom" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Estimated Value" data-value="{{ job.value }}" data-onblur="submit">{{ job.value|number }}</a>
                </strong>
                </p>

                <p>
                    <a href="#" class="xedit" id="description" data-type="textarea" data-mode="inline" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Description" data-value="{{ job.description|escape }}" data-emptyText="Description..." data-onblur="submit">{{ job.description|escape }}</a>
                </p>

                <p>
                    Quoted via 
                    <strong>
                        <a href="#" class="xedit" id="type" data-type="select" data-placement="bottom" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Quoted Via" data-value="{{ job.origin.id }}" data-source="[{% for type in types %}{% if loop.index0 is not 0 %},{% endif %}{value: {{ type.id }}, text: '{{ type.name }}'}{% endfor %}]" data-onblur="submit">{{ job.origin.name }}</a>
                    </strong>
                     by
                    <strong>
                        <a href="#" class="xedit" id="user" data-type="select" data-placement="bottom" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Sales Rep" data-value="{{ job.rep.id }}" data-source="[{% for rep in users %}{% if loop.index0 is not 0 %},{% endif %}{value: {{ rep.id }}, text: '{{ rep.name }}'}{% endfor %}]" data-onblur="submit">{{ job.rep.name }}</a>
                    </strong>

                    <strong class="pull-right">
                        <a href="#" class="xedit" id="customer" data-type="text" data-placement="bottom" data-pk="{{ job.id }}" data-url="/hotlist/update" data-title="Customer" data-value="{{ job.customer }}" data-onblur="submit">{{ job.customer }}</a>
                    </strong>
                </p>

				</li>
			{% endfor %}
		</ul>
	</div>
	{% endfor %}
    {% if hot|length > 0 %}
    <div class="category">
        <ul class="list-group searchable" id="list-hot">
            <li class="group-header ingnore-me">
                <h4 class="list-group-item-heading">Hot Quotes</h4>
                <span class="count"></span> Quotes
                <span class="total"></span>
            </li>
            {% for quote in hot %}
                <li class="list-group-item item" data-id="{{ quote.quoteId }}" data-value="{{ quote.value }}">
                <strong>{{ quote.reference|escape }} <span class="pull-right">${{ quote.value|number }}</span></strong>
                <br>
                <a href='{{ url('quotes/view/' ~ quote.quoteId) }}' >View Quote <i class="fa fa-external-link"></i></a>
                <strong class="pull-right">{{ quote.customer.customerName }}</strong>
                </li>
            {% endfor %}
        </ul>
    </div>
    {% endif %}
</div>
<div id="actions">
	<ul class="action-list" id="lost">
		<li class="action-title">Lost</li>
	</ul>
	<ul class="action-list" id="won">
		<li class="action-title">Won</li>
	</ul>
</div>

<div class="modal fade" id="add">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/hotlist/create" method="POST" role="form" autocomplete="off">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Add a Job</h4>
                </div>
                <div class="modal-body">
                    {% for element in newForm %}
                        <div class="form-group">
                            {{ element.label() }}
                            {{ element.render() }}
                        </div>
                        {% endfor %}
                        <strong>Category</strong>
                        <br>
                        <div class="btn-group colors" data-toggle="buttons">
                            {% for category in categories %}
                            <label class="btn btn-primary {% if loop.index0 === 0 %}active{% endif %}">
                                <input type="radio" name="category" value="{{ category.id }}" autocomplete="off" {% if loop.index0 === 0 %}checked="checked"{% endif %}> {{ category.name }}
                            </label>
                            {% endfor %}
                        </div>
                        <br>
                        <br>
                        <strong>Quote Via</strong>
                        <br>
                        <div class="btn-group colors" data-toggle="buttons">
                            {% for type in types %}
                            <label class="btn btn-primary {% if loop.index0 === 0 %}active{% endif %}">
                                <input type="radio" name="type" value="{{ type.id }}" autocomplete="off" {% if loop.index0 === 0 %}checked="checked"{% endif %}> {{ type.name }}
                            </label>
                            {% endfor %}
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="categories">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="/hotlist/categories" method="POST" role="form">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Categories</h4>
				</div>
				<div class="modal-body">

                <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Enabled</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% for category in categories %}
                            <tr>
                                <td>{{ category.name }}</td>
                                <td><div class="checkbox">
                                    <label>
                                        <input type="checkbox" value="{{ category.id }}" checked="checked">
                                        Enabled?
                                    </label>
                                </div></td>
                            </tr>
                        {% endfor %}
                        </tbody>
                    </table>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="details">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Modal title</h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<script type="text/javascript">
    $('document').ready(function(){
        var addup = function() {
            var tsum = 0;
            var tcount = 0;
            $('.list-group').each(function() {
                var sum = 0;
                var count = 0;
                var list = $( this ).attr('id');
                $('#' + list + ' li.item').not('.exclude').each(function() {
                    var p = parseFloat($(this).data('value'));
                    count += 1;
                    sum += p;
                });
                $('#' + list + ' span.total').text('$' + sum.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                $('#' + list + ' span.count').text(count);
                tsum += sum;
                tcount += count;
            });
            $('span#tsum').text('$' + tsum.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
            $('span#tcount').text(tcount);
        };
        addup();

{% for category in categories %}
    var list{{ loop.index }} = document.getElementById('list{{ category.id }}');
    var sortable{{ category.id }} = Sortable.create(list{{ loop.index }},{
        group: "quotes",
        animation: 200,
        scroll: true, // or HTMLElement
        handle: '.item',
        filter: ".ignore-me",
        draggable: ".item",
        scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
        scrollSpeed: 30, // px
            // dragging started
        onStart: function (/**Event*/evt) {
            $("#actions").css("bottom", "0px");
        },
        onEnd: function () {
            setTimeout(function() {if(updating = true) {
                $("#actions").css("bottom", "-100px");
            }}, 100);
        },

        // dragging ended
        onAdd: function(evt){
            $("#actions").css("bottom", "-100px");
            $.post('/hotlist/updatestatus', {'status': '{{ category.id }}', 'quote': $(evt.item).data('id')})
        }    ,

        onSort: function() {
            addup('list{{ loop.index }}')
        }

    });
{% endfor %}


var sortableFour = Sortable.create(document.getElementById('lost'),{
    group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
        $.post('/hotlist/lost', {'quote': $(evt.item).data('id')});
        setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
        setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
        setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
        setTimeout(function() {$('#lost .action-title').html('Lost');}, 1400);
    }
});
var sortableFive = Sortable.create(document.getElementById('won'),{
    group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
        $.post('/hotlist/won', {'quote': $(evt.item).data('id')});
        setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
        setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
        setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
        setTimeout(function() {$('#won .action-title').html('Won');}, 1400);
    }
});

  $('[data-toggle="tooltip"]').tooltip()
});
</script>
<style type="text/css">
.pipeline-container, .col {
    padding-left: 0px;
    padding-right: 0px;
}
textarea.form-control.input-large, .editable-input, .control-group.form-group, span.editable-container.editable-inline {
    width: 100%;
}
.page-header {
    margin: 40px 0 0;
}
.pipeline-container {
    padding: 0px;
}
li.list-group-item.item {
    width: 100%;
}
label.btn.btn-primary.active {
    background: #607D8B;
    border-color: #607d8b;
}

ul.discussion {
    padding: 0;
    margin: 0;
}
.list-group li:last-child {
    box-shadow: 0 6px 11px -7px rgba(0,0,0,.2);
}
.list-group {
    box-shadow: none;
    min-height: 120px;
}
.editable-click, a.editable-click {
    display: inline-block;
    color: #434a54;
    transition: background 0.3s;
}
li:hover .editable-click, li:hover a.editable-click, li:hover a.editable-click:hover {
    background: #fff9b9;
    border-bottom: 1px dashed #f6bb42;
    margin-bottom: -1px;
}
.editable-click, a.editable-click, a.editable-click:hover {
    text-decoration: none;
    border-bottom: none;
    padding: 0 2px;
}
.arrow-btn {
    height: 4.5em;
    padding-top: 1.7em;
    padding-left: 1em;
    padding-bottom: 2em;
    padding-right: 0em;
}
div#actions {
    position: fixed;
    bottom: -100px;
    text-align: center;
    width: 100%;
    background: rgb(66, 66, 66);
    border-top: 1px solid black;
    padding: 12px;
    animation: all 5s;
    transition: 0.3s ease-in;
}
    #actions li.item{
    	display: none;
    	height: 0px !important;
    	width: 0px !important;
    	overflow: hidden;
    	padding: 0px !important;
    	border: 0px !important;
    	margin: 0px !important;
    }
    ul#lost {
        background: #ce3644;
    }
    ul#won {
        background: #85CE36;
    }
    ul.action-list {
        display: inline-block;
        width: 30%;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        list-style: none;
        margin: 10px;
        padding: 10px;
        animation: all;
        transition: 0.2s ease-in;
        align-self: center;
    }
    li.list-group-item.active {
        border-radius: 0px;
    }
li.group-header {
    padding: 14px;
    background: #009688;
    list-style: none;
    color: white;
    margin: 0;
}
    .list-group-item-heading {
        color: #ffffff;
    }
    a {
        color: #808080;
    }

</style>
