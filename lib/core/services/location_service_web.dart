// location_service_web.dart
import 'dart:html' as html;
import 'package:UnlockMe/core/utils/logger.dart';

import 'location_service.dart';

LocationService getInstance() => LocationServiceWeb();

class LocationServiceWeb implements LocationService {
  @override
  Future<void> requestLocationPermission(
      Function(double?, double?) updateMapLocation) async {
    await html.window.navigator.geolocation
        .getCurrentPosition(enableHighAccuracy: true)
        .then(
      (geoPosition) {
        updateMapLocation(geoPosition.coords?.latitude?.toDouble(),
            geoPosition.coords?.longitude?.toDouble());
      },
    ).catchError(
      (error) {
        Logger.logError('Error: $error');
      },
    );
  }
}
