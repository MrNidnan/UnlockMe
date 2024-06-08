import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// This class defines the variables used in the [mapa_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class MapaModel {
  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
  RxList<Marker> markers = <Marker>[].obs;
  //late Rx<MarkerLayer> markerLayer;

  MapaModel({
    LatLng? initialPosition,
    List<Marker>? initialMarkers,
  }) {
    currentPosition.value = initialPosition ?? const LatLng(41.3851, 2.1734);
    if (initialMarkers != null) {
      markers.addAll(initialMarkers);
      //markerLayer = MarkerLayer(markers: markers).obs;
    }
  }
}
