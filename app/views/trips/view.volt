<script src='{{ static_url("js/mapbox-gl.3.4.0.js") }}'></script>
<link href='{{ static_url("css/mapbox-gl.3.4.0.css") }}' rel='stylesheet' />

<div id='map'></div>
<div id='sidebar' class='sidebar'>
	<h4 class=''>{{ trip.name }}</h4>
	<ul id="locations" class="list-group">
		{% for stop in trip.stops %}
		<li class="list-group-item d-flex align-items-center">
			{{ stop.customer.name }}
		</li>
		{% endfor %}
	</ul>
	<a href="/trips/delete/{{ trip.niceName }}" class="btn btn-danger mt-3 delete confirm-delete">Delete trip</a>
</div>

<script src="/js/sortable.1.15.2.min.js"></script>
<script>
Sortable.create($('#locations')[0], {
	animation: 200,
	swapThreshold: 0.5,
});
mapboxgl.accessToken = '{{ mapBoxKey }}';
const map = new mapboxgl.Map({
	container: 'map',
	style: 'mapbox://styles/mapbox/streets-v12',
	center: [175.2706058, -40.6353817],
	zoom: 5,
	projection: 'mercator',
	// Do not allow the user to pitch/rotate the map
	pitchWithRotate: false,
	dragRotate: false,
});
map.on('load', () => {
	// Fixes a bug where the map doesn't render properly (bottom half is blank)
	map.resize();
});

</script>

<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
nav.navbar {
	margin-bottom: 0 !important;
	z-index: 1000;
}
#map {
	position: absolute;
	top: 0;
	bottom: 0;
	right: 0;
	width: calc(100% - 450px);
	height: 100%;
	z-index: 1;
}
#sidebar {
	position: absolute;
	top: 0;
	left: 0;
	width: 450px;
	height: 100%;
	padding: 5em 1em 1em 1em;
	z-index: 2;
	display: flex;
	flex-direction: column;
}
#clear-button {
	position: absolute;
	top: 0px;
	bottom: 0px;
	right: 1px;
	z-index: 1000;
}
#clear-button:hover, #clear-button:focus, #clear-button:active {
	box-shadow: none;
}
#clear-button svg {
	width: 1.3em;
	height: 1.3em;
}
li {
	cursor: move;
}
</style>
