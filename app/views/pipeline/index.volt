{{ content() }}
<p id="total"></p>
<div class="alert alert-default collapse" id="help">
    <strong>Pipeline quick start guide</strong> <br> <br>
    <ul>
    <li>The <strong>pipeline</strong> organises quotes by status and then by date (oldest at the top).</li>
    <li><strong>Update quotes </strong> by dragging on the grey bar. You can mark quotes as sold / lost or
        change the status by doing this. </li>
    <li><strong>Searching </strong> is done on the fly using the search on the right hand side.</li>
    <li><strong>View quotes </strong> by clicking the arrow.</li>
    </ul>
    <br>
    <strong>Color Key</strong>
    <br>
    <br>
    <ul>
    <li><strong>Grey Quotes</strong></span> indicate <strong>no</strong> follow ups</li>
    <li><span class="text-danger"><strong>Red Quotes</strong></span> indicate <span class="text-danger"><strong>overdue</strong></span> follow ups</li>
    <li><span class="text-success"><strong>Green Quotes</strong></span> indicate <span class="text-success"><strong>on track</strong></span> follow ups</li>
    <li><span class="text-info"><strong>Blue Quotes</strong></span> indicate <span class="text-success"><strong>todays</strong></span> follow ups</li>
    </ul>
</div>
<div class="row">
    <div class="col-xs-6 col-sm-9 col-md-9 col-lg-9">
    </div>
	<div class="col-xs-6 col-sm-3 col-md-3 col-lg-3">
		<input type="text" name="search" id="input" class="form-control pull-right" placeholder="Search" autofocus="true" value="{{ user }}">
	</div>
</div>
<br>
<div class="row row-flex row-flex-wrap">
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 no-padding">
		<ul class="flex-panel list-group searchable" id="cold">
			<li class="group-header ingnore-me">
				<h4 class="list-group-item-heading">Cold Quotes</h4>
                <p><span class="count">{{ coldCount }}</span> - <span class="total">${{ coldValue|number }}</span></p>
			</li>
			{% for item in cold %}
				<li class="list-group-item item {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% elseif item.followUpStatus == 3 %}today{% else %}nostatus{% endif %}" data-id="{{ item.quoteId }}" data-value="{{ item.value }}">
                <a href="/quotes/view/{{ item.quoteId }}"><span class="arrow pull-right"><i class="fa fa-icon fa-arrow-circle-right"></i></span></a>
                <span class="my-handle"></span>
                <strong>{{ item.reference }}</strong> <span class="pull-right">${{ item.value|number }}</span> <br>
                {% if item.customer %} {{ item.customer.name }} {% endif %}<span class="pull-right">{{ item.rep.name }}</span><br>
                {{ item.quoteId }} - {{ date("d-m-Y", strtotime(item.date)) }} {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% elseif item.followUpStatus == 3 %}today{% endif %}
				</li>
			{% endfor %}
		</ul>
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 no-padding">
		<ul class="flex-panel list-group searchable" id="warm">
			<li class="group-header ingnore-me">
				<h4 class="list-group-item-heading">Warm Quotes</h4>
                <p><span class="count">{{ warmCount }}</span> - <span class="total">${{ warmValue|number }}</span></p>
			</li>
			{% for item in warm %}
				<li class="list-group-item item {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% elseif item.followUpStatus == 3 %}today{% else %}nostatus{% endif %}" data-id="{{ item.quoteId }}" data-value="{{ item.value }}">
                <a href="/quotes/view/{{ item.quoteId }}"><span class="arrow pull-right"><i class="fa fa-icon fa-arrow-circle-right"></i></span></a>
                <span class="my-handle"></span>
                <strong>{{ item.reference }}</strong> <span class="pull-right">${{ item.value|number }}</span> <br>
                {% if item.customer %} {{ item.customer.name }} {% endif %}<span class="pull-right">{{ item.rep.name }}</span><br>
                {{ item.quoteId }} - {{ date("d-m-Y", strtotime(item.date)) }} {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% endif %}
				</li>
			{% endfor %}
			</ul>
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 no-padding">
		<ul class="flex-panel list-group searchable" id="hot">
			<li class="group-header ingnore-me">
				<h4 class="list-group-item-heading">Hot Quotes </h4>
                <p><span class="count">{{ hotCount }}</span> - <span class="total">${{ hotValue|number }}</span></p>
			</li>
			{% for item in hot %}
				<li class="list-group-item item {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% elseif item.followUpStatus == 3 %}today{% else %}nostatus{% endif %}" data-id="{{ item.quoteId }}" data-value="{{ item.value }}">
                <a href="/quotes/view/{{ item.quoteId }}"><span class="arrow pull-right"><i class="fa fa-icon fa-arrow-circle-right"></i></span></a>
                <span class="my-handle"></span>
                <strong>{{ item.reference }}</strong> <span class="pull-right">${{ item.value|number }}</span> <br>
                {% if item.customer %} {{ item.customer.name }} {% endif %}<span class="pull-right">{{ item.rep.name }}</span><br>
                {{ item.quoteId }} - {{ date("d-m-Y", strtotime(item.date)) }} {% if item.followUpStatus == 1 %}overdue{% elseif item.followUpStatus == 2 %}current{% endif %}
				</li>
			{% endfor %}
			</ul>
	</div>
</div>
</div>
<div id="actions">
	<ul class="action-list" id="lost">
		<li class="action-title">Lost</li>
	</ul>
	<ul class="action-list" id="won">
		<li class="action-title">Won</li>
	</ul>
</div>

<script type="text/javascript">
$('document').ready(function(){

var listOne = document.getElementById('cold');
var listTwo = document.getElementById('warm');
var listThree = document.getElementById('hot');
var listFour = document.getElementById('lost');
var listFive = document.getElementById('won');
var sortableCold = Sortable.create(listOne,{
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
    onUpdate: function () {
    	setTimeout(function() {if(updating = true) {
        	$("#actions").css("bottom", "-100px");
    	}}, 100);
    },

    // dragging ended
    onAdd: function(evt){
    	$("#actions").css("bottom", "-100px");
    	$.post('/pipeline/updatestatus', {'status': '3', 'quote': $(evt.item).data('id')})
    }    ,

    onSort: function() {
        addup('cold')
    }

});
var sortableWarm = Sortable.create(listTwo,{
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
    onUpdate: function () {
    	setTimeout(function() {if(updating = true) {
        	$("#actions").css("bottom", "-100px");
    	}}, 100);
    },

    // dragging ended
    onAdd: function(evt){
    	$("#actions").css("bottom", "-100px");
    	$.post('/pipeline/updatestatus', {'status': '2', 'quote': $(evt.item).data('id')})
    },

    onSort: function() {
        addup('warm')
    }

});
var sortableHot = Sortable.create(listThree,{
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
    onUpdate: function () {
    	setTimeout(function() {if(updating = true) {
        	$("#actions").css("bottom", "-100px");
    	}}, 100);
    },

    // dragging ended
    onAdd: function(evt){
    	$("#actions").css("bottom", "-100px");
    	$.post('/pipeline/updatestatus', {'status': '1', 'quote': $(evt.item).data('id')})
    },

    onSort: function() {
        addup('hot')
    }
});
var sortableFour = Sortable.create(listFour,{
	group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
    	$.post('/pipeline/updatestatus', {'status': '4', 'quote': $(evt.item).data('id')});
    	setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
    	setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
    	setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
    	setTimeout(function() {$('#lost .action-title').html('Lost');}, 1400);
    }
});
var sortableFive = Sortable.create(listFive,{
	group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
    	$.post('/pipeline/sale/'+$(evt.item).data('id'));
    	setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
    	setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
    	setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
    	setTimeout(function() {$('#won .action-title').html('Won');}, 1400);
    }
});
console.log(sum)
});
$('input[name="search"]').keyup();
$('input[name="search"]').keyup(function(){

    var that = this, $allListElements = $('ul > li.item');

    var $matchingListElements = $allListElements.filter(function(i, li){
        var listItemText = $(li).text().toUpperCase(),
            searchText = that.value.toUpperCase();
        return ~listItemText.indexOf(searchText);
    });

    $allListElements.hide().addClass('exclude');
    $matchingListElements.show().removeClass('exclude');
    addup('all');

});

</script>
<script type="text/javascript">
var addup = function() {
    $('.list-group').each(function() {
        var sum = 0;
        var count = 0;
        var list = $( this ).attr('id');
        $('#' + list + ' li.item').not('.exclude').each(function() {
            var p = parseFloat($(this).data('value'));
            count += 1;
            sum += p;
        });
        $('#' + list + ' span.total').text('$' + sum.toFixed(2).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        $('#' + list + ' span.count').text(count);
    });
};
</script>

<style type="text/css">
li.list-group-item.item {
    width: 100%;
}
    .no-padding {
        padding: 0px;
    }
    .arrow {
        height: 4.5em;
        padding-top: 1.7em;
        padding-left: 1em;
        padding-bottom: 2em;
        padding-right: 0em;
    }
    ul#hot, ul#warm, ul#cold {
        display: block;
        background: whitesmoke;
        width: 100%;
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
        background: #4f5f6f;
    }
    .list-group-item-heading {
        color: #ffffff;
        text-shadow: 1px 1px 10px #36414c;
    }
    .group-header p {
        color: white;
        margin: 0;
    }
    a {
        color: #808080;
    }
</style>
