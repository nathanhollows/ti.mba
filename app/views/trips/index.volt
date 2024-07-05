<script src='{{ static_url("js/mapbox-gl.3.4.0.js") }}'></script>
<link href='{{ static_url("css/mapbox-gl.3.4.0.css") }}' rel='stylesheet' />

<div id='map'></div>
<div id='sidebar' class='sidebar shadow-lg'>
	<div class="input-group mb-3">
		<input id="loc-search" type="text" class="form-control" placeholder="Search locations">
		<button id="clear-button" class="btn btn-ghost btn-sm" type="button" id="button-addon2">
			{{ icon('x') }}
		</button>
	</div>
	<div class='sidebar-wrapper'>
		<ul class="nav nav-tabs mb-3 justify-content-center" id="pills-tab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Regions</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">On the map</a>
			</li>
		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
				...
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
				...
			</div>
			<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
				...
			</div>
		</div>
	</div>
</div>

<script>
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
document.getElementById('clear-button').addEventListener('click', () => {
	document.getElementById('loc-search').value = '';
	document.getElementById('loc-search').focus();
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
	background-color: #fff;
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
</style>
