<!-- Include Mapbox GL JS and CSS -->
<script src="{{ static_url('js/mapbox-gl.3.4.0.js') }}"></script>
<link href="{{ static_url('css/mapbox-gl.3.4.0.css') }}" rel="stylesheet" />

<!-- Map Container -->
<div id="map"></div>

<!-- Sidebar Form -->
<form id="sidebar" class="sidebar h-100" action="/trips/save/{{ trip.niceName }}" method="post">
    {{ content() }}
    {{ flashSession.output() }}
    {{ flash.output() }}
    <div class="form-group mb-3">
        <label for="name">Trip name</label>
        <input type="text" class="form-control" id="name" name="name" value="{{ trip.name }}" list="salesareas" autocomplete="off" required>
        <datalist id="salesareas">
            {% for area in salesAreas %}
            <option value="{{ area.area }}">{{ area.area }}</option>
            {% endfor %}
        </datalist>
        <input type="hidden" name="id" value="{{ trip.id }}">
    </div>

    <label>Stops 
        <span class="text-muted">({{ trip.stops|length }})</span>
    </label>
    {% if trip.stops|length > 12 %}
    <small class="text-muted">Note: Route optimisation is limited to 12 stops</small>
    {% endif %}
    <div id="locations" class="form-group mb-3 overflow-scroll">
        <ul id="locations-list" class="list-group">
            {% for stop in trip.stops %}
            <li class="list-group-item d-flex align-items-center" data-index="{{ loop.index0 }}">
                {{ emicon('grip-vertical') }}
                <span class="marker">
                    <span>
                        <b>{{ loop.index }}</b>
                    </span>
                </span>
                {{ stop.customer.name }}
                <input type="hidden" name="customerCode[]" value="{{ stop.customer.customerCode }}">
                {% if not stop.customer.getCoordinates()['lat'] %}
                <span class="badge bg-warning text-dark ms-auto">No coordinates</span>
                {% endif %}
                <button type="button" class="btn btn-danger btn-sm ms-auto remove-stop" data-index="{{ loop.index0 }}">Remove</button>
            </li>
            {% endfor %}
        </ul>
    </div>

    <div id="links">
        <hr class="w-100">
        <div>
            <a href="/trips/delete/{{ trip.niceName }}" class="btn btn-danger delete confirm-delete">Delete</a>
            <button type="submit" formaction="/reports/customerdetails" class="btn btn-secondary" id="contact-details">
                Print reports
            </button>
            <div class="btn-group dropup">
                <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Optimise</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#" id="cluster-visible">Cluster Visible</a>
                    <a class="dropdown-item" href="#" id="reverse-visible">Reverse Visible</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Separated link</a>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
        </div>
    </div>
</form>

<!-- Include Sortable JS -->
<script src="/js/sortable.1.15.2.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Sortable
    const sortableList = document.getElementById('locations-list');
    Sortable.create(sortableList, {
        animation: 200,
        swapThreshold: 0.5,
        handle: '.icon',
        onEnd: updateOrder
    });

    // Initialize Mapbox
    mapboxgl.accessToken = '{{ mapBoxKey }}';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v11',
        center: [175.2706058, -40.6353817],
        zoom: 5,
        projection: 'mercator',
        pitchWithRotate: false,
        dragRotate: false,
    });

    let markers = [];
    let bounds = new mapboxgl.LngLatBounds();
    let stops = getStops();

    // Sort stops by latitude (north to south)
    stops.sort((a, b) => b.coordinates[1] - a.coordinates[1]);

    // Add markers to the map
    stops.forEach(stop => {
        addMarker(stop, markers, bounds, map);
    });

    // Fit map to bounds
    map.on('load', () => {
        map.resize();
        map.fitBounds(bounds, { padding: 100 });
        updateListVisibility();
    });

    map.on('moveend', updateListVisibility);

    function getStops() {
        let stops = [];
        {% for index, stop in trip.stops %}
            {% if stop.customer.getCoordinates()['lng'] %}
                stops.push({
                    index: {{ index }},
                    coordinates: [
                        {{ stop.customer.getCoordinates()['lng'] }},
                        {{ stop.customer.getCoordinates()['lat'] }}
                    ],
                    name: '{{ stop.customer.name|escape }}',
                    customerCode: '{{ stop.customer.customerCode }}'
                });
            {% endif %}
        {% endfor %}
        return stops;
    }

    function addMarker(stop, markers, bounds, map) {
        let markerElement = document.createElement('div');
        markerElement.className = 'marker';
        markerElement.innerHTML = `<span><b>${stop.index + 1}</b></span>`;
        markerElement.style.zIndex = Math.abs(Math.round(stop.coordinates[1] * 1000)); // Adjust zIndex based on latitude

        let marker = new mapboxgl.Marker(markerElement)
            .setLngLat(stop.coordinates)
            .setPopup(new mapboxgl.Popup({ offset: 25 }).setText(stop.name))
            .addTo(map);

        markers[stop.index] = marker;
        bounds.extend(stop.coordinates);

        // Attach hover events to list items
        document.querySelector(`[data-index="${stop.index}"]`).addEventListener('mouseover', function() {
            markerElement.classList.add('hover');
            marker.togglePopup();
        });

        document.querySelector(`[data-index="${stop.index}"]`).addEventListener('mouseout', function() {
            markerElement.classList.remove('hover');
            marker.togglePopup();
        });

        // Attach click event to zoom to marker
        document.querySelector(`[data-index="${stop.index}"]`).addEventListener('click', function() {
            map.flyTo({ center: stop.coordinates, zoom: 14 });
        });

        // Attach click event to remove stop
        document.querySelector(`[data-index="${stop.index}"] .remove-stop`).addEventListener('click', function() {
            removeStop(stop.index);
        });
    }

    function updateOrder() {
        // Get the new order from the list
        let newOrder = [];
        document.querySelectorAll('#locations-list li').forEach((li, index) => {
            const customerCode = li.querySelector('input[name="customerCode[]"]').value;
            const stop = stops.find(stop => stop.customerCode === customerCode);
            stop.index = index;
            newOrder.push(stop);
        });

        // Update stops array
        stops = newOrder;

        // Clear existing markers
        markers.forEach(marker => marker.remove());

        // Add markers in new order
        stops.forEach(stop => {
            addMarker(stop, markers, bounds, map);
        });

        updateBadges();
    }

    function updateBadges() {
        document.querySelectorAll('#locations-list li').forEach((li, index) => {
            li.querySelector('.marker b').textContent = index + 1;
        });
    }

    function updateListVisibility() {
        const bounds = map.getBounds();
        document.querySelectorAll('#locations-list li').forEach((li, index) => {
            const customerCode = li.querySelector('input[name="customerCode[]"]').value;
            const stop = stops.find(stop => stop.customerCode === customerCode);
            const coordinates = new mapboxgl.LngLat(stop.coordinates[0], stop.coordinates[1]);
            if (bounds.contains(coordinates)) {
                li.classList.remove('muted');
            } else {
                li.classList.add('muted');
            }
        });
    }

    function removeStop(index) {
        // Remove the stop from the stops array
        stops.splice(index, 1);

        // Update the order of stops
        stops.forEach((stop, idx) => {
            stop.index = idx;
        });

        // Update the list and markers
        updateList();
        updateMarkers();
    }

    function updateList() {
        const list = document.getElementById('locations-list');
        list.innerHTML = '';
        stops.forEach((stop, index) => {
            const li = document.createElement('li');
            li.className = 'list-group-item d-flex align-items-center';
            li.setAttribute('data-index', index);

            // Add the necessary elements to the list item
            li.innerHTML = `
                {{ emicon('grip-vertical') }}
                <span class="marker">
                    <span>
                        <b>${index + 1}</b>
                    </span>
                </span>
                ${stop.name}
                <input type="hidden" name="customerCode[]" value="${stop.customerCode}">
                ${stop.coordinates[1] === null ? '<span class="badge bg-warning text-dark ms-auto">No coordinates</span>' : ''}
                <button type="button" class="btn btn-danger btn-sm ms-auto remove-stop" data-index="${index}">Remove</button>
            `;

            list.appendChild(li);
        });

        // Reattach event listeners to the new remove buttons
        document.querySelectorAll('.remove-stop').forEach(button => {
            button.addEventListener('click', function() {
                const index = parseInt(button.getAttribute('data-index'), 10);
                removeStop(index);
            });
        });
    }

    function updateMarkers() {
        // Clear existing markers
        markers.forEach(marker => marker.remove());

        // Add new markers in updated order
        markers = [];
        bounds = new mapboxgl.LngLatBounds();
        stops.forEach(stop => {
            addMarker(stop, markers, bounds, map);
        });

        // Fit map to bounds
        map.fitBounds(bounds, { padding: 100 });
    }

    // Handle "Cluster Visible" option
    document.getElementById('cluster-visible').addEventListener('click', function(e) {
        e.preventDefault();
        clusterVisible();
    });

    function clusterVisible() {
        let visibleStops = [];
        let hiddenStops = [];
        let topVisibleIndex = Infinity;
        document.querySelectorAll('#locations-list li').forEach((li, index) => {
            if (!li.classList.contains('muted')) {
                visibleStops.push(li);
                if (index < topVisibleIndex) {
                    topVisibleIndex = index;
                }
            } else {
                hiddenStops.push(li);
            }
        });
        let newOrder = hiddenStops.slice(0, topVisibleIndex).concat(visibleStops).concat(hiddenStops.slice(topVisibleIndex));
        newOrder.forEach((li, index) => {
            sortableList.appendChild(li);
        });
        updateOrder();
    }

    // Handle "Reverse Visible" option
    document.getElementById('reverse-visible').addEventListener('click', function(e) {
        e.preventDefault();
        reverseVisible();
    });

    function reverseVisible() {
        let visibleStops = [];
        let hiddenStops = [];
        document.querySelectorAll('#locations-list li').forEach((li) => {
            if (!li.classList.contains('muted')) {
                visibleStops.push(li);
            } else {
                hiddenStops.push(li);
            }
        });

        let reversedVisibleStops = visibleStops.reverse();
        
        let newOrder = [];
        let visibleIndex = 0;
        document.querySelectorAll('#locations-list li').forEach((li) => {
            if (!li.classList.contains('muted')) {
                newOrder.push(reversedVisibleStops[visibleIndex++]);
            } else {
                newOrder.push(li);
            }
        });

        newOrder.forEach((li) => {
            sortableList.appendChild(li);
        });
        updateOrder();
    }
});
</script>

<style>
.marker {width:0; height:0;}

.marker span {
		display:flex;
		justify-content:center;
		align-items:center;
		box-sizing:border-box;
		width: 30px;
		height: 30px;
		color:#fff;
		background: #152b3e;
		border:solid 2px;
		border-radius: 0 70% 70%;
		box-shadow:0 0 2px #000;
		cursor: pointer;
		transform-origin:0 0;
		transform: rotateZ(-135deg);
}
.mapboxgl-popup {
  z-index: 100000;
}
#locations-list .marker {
		width: auto;
}
#locations-list .marker span {
		width: 20px;
		height: 20px;
		background: #152b3e;
		border: solid 1px;
		border-radius: 0 70% 70%;
		box-shadow: unset;
		cursor: pointer;
		transform-origin: 5px 5px;
		transform: rotateZ(-135deg);
		font-size: 0.8em;
}
.marker.hover span {
		background-color: var(--primary);
}
.marker b {transform: rotateZ(135deg)}
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
		top: 50px;
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
#locations {
		overflow: scroll;
}
#locations-list li.muted {
		opacity: 0.5;
}
#locations-list li .icon {
		cursor: move;
		margin-left: -0.5em;
		margin-right: 0.5em;
}
#locations-list li.sortable-ghost {
		background-color: rgba(255, 255, 255, 0.5);
}
#sidebar label {
		margin-bottom: 0;
		font-weight: bold;
		font-size: 1em;
}
#sidebar form li {
		padding-left: 0;
}
#sidebar #links {
		margin-top: auto;
}
#sidebar #links > div {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		gap: 0.5em;
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
.text-muted {
		color: #6c757d !important;
}
</style>
