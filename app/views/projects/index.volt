{{ content() }}


<div class="list-group">
</div>

<div class="row">
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<ul class="list-group" id="cold">
			<li class="list-group-item active ignore-me">
				<h4 class="list-group-item-heading">Cold Quotes</h4>
				<p class="list-group-item-text"><input id="search" name="search" class="form-control" placeholder="Search" type="text" data-list="#cold"></p>
			</li>
			{% for item in cold %}
				<li class="list-group-item item" data-id="{{ item.quoteId }}">
				<span class="my-handle"></span>
				{{ item.reference }} <span class="pull-right">{% if item.customer %} {{ item.customer.customerName }} {% endif %}</span><br>
				{{ date("d M Y", strtotime(item.date)) }}
				<span class="pull-right">{{ item.rep.name }}</span>
				</li>
			{% endfor %}
		</ul>	
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<ul class="list-group list" id="warm">
			<li class="list-group-item active ignore-me">
				<h4 class="list-group-item-heading">Warm Quotes</h4>
				<p class="list-group-item-text"><input id="search2" name="search" class="form-control" placeholder="Search" type="text" data-list="#warm"></p>
			</li>
			{% for item in warm %}
				<li class="list-group-item item" data-id="{{ item.quoteId }}">
				<a href="{{ url('/quotes/view/' ~ item.quoteId ) }}">
				<span class="my-handle"></span>
				{{ item.reference }} <span class="pull-right">{% if item.customer %} {{ item.customer.customerName }} {% endif %}</span><br>
				{{ date("d M Y", strtotime(item.date)) }}
				<span class="pull-right">{{ item.rep.name }}</span>
				</a>
				</li>
			{% endfor %}
			</ul>	
	</div>
	<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
		<ul class="list-group" id="hot">
			<li class="list-group-item active ignore-me">
				<h4 class="list-group-item-heading">Hot Quotes</h4>
				<p class="list-group-item-text"><input id="search3" name="search" class="form-control" placeholder="Search" type="text" data-list="#hot"></p>
			</li>
			{% for item in hot %}
				<li class="list-group-item item" data-id="{{ item.quoteId }}">
				<span class="my-handle"></span>
				{{ item.reference }} <span class="pull-right">{% if item.customer %} {{ item.customer.customerName }} {% endif %}</span><br>
				{{ date("d M Y", strtotime(item.date)) }}
				<span class="pull-right">{{ item.rep.name }}</span>
				</li>
			{% endfor %}
			</ul>	
	</div>
</div>

<script type="text/javascript">
$('document').ready(function(){

var listOne = document.getElementById('cold');
var listTwo = document.getElementById('warm');
var listThree = document.getElementById('hot');
var sortableCold = Sortable.create(listOne,{
	group: "quotes",
	animation: 200,
    scroll: true, // or HTMLElement
    handle: '.my-handle',
    filter: ".ignore-me", 
    draggable: ".item",
    scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
    scrollSpeed: 30, // px
    // dragging ended
    onAdd: function(){
    	console.log(sortableCold.toArray())
    }    

});
var sortableWarm = Sortable.create(listTwo,{
	group: "quotes",
	animation: 200,
    scroll: true, // or HTMLElement
    handle: '.my-handle',
    filter: ".ignore-me", 
    draggable: ".item",
    scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
    scrollSpeed: 30, // px
    // dragging ended
    onAdd: function(){
    	console.log(sortableWarm.toArray())
    }

});
var sortableHot = Sortable.create(listThree,{
	group: "quotes",
	animation: 200,
    scroll: true, // or HTMLElement
    handle: '.my-handle',
    filter: ".ignore-me", 
    draggable: ".item",
    scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
    scrollSpeed: 30, // px
    // dragging ended
    onAdd: function(){
    	console.log(sortableHot.toArray(), "1");
    }
});
 $('#search').hideseek({
 	ignore: '.ignore-me'
 });
 $('#search2').hideseek({
 	ignore: '.ignore-me'
 });
 $('#search3').hideseek({
 	ignore: '.ignore-me'
 });
});

</script>

<style type="text/css">
ul#hot, ul#warm, ul#cold {
    display: block;
    background: whitesmoke;
    min-height: 141px;
}
</style>