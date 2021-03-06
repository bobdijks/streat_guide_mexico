import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // only build a map if there’s a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
    fitMapToMarkers(map, markers);
    const mapboxmarkers = addMarkersToMap(map, markers);
    markerupdate(mapboxmarkers);
  };
};

const addMarkersToMap = (map, markers) => {
  const mapboxmarkers = {}
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this
    const mapmarker = new mapboxgl.Marker({
      color: '#438267'
    })
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup) // add this
      .addTo(map);
      mapboxmarkers[marker.id] = mapmarker
  });
  return mapboxmarkers
};

export { initMapbox };


const markerupdate = (markers) => {
  const stallcardselector = document.querySelectorAll('.stall-card');
      stallcardselector.forEach (stall=> {
        stall.addEventListener('mouseover',
          event => {
            const marker = markers[stall.id]
            marker.getElement().querySelector('g').querySelectorAll('g')[1].style.fill = '#f4a207';
          })
        stall.addEventListener('mouseout',
          event => {
            const marker = markers[stall.id]
            marker.getElement().querySelector('g').querySelectorAll('g')[1].style.fill = '#438267';
          })
      })
      console.log(markers)
}



