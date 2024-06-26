// location_service_mobile.dart
import 'package:unlockme/core/utils/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

LocationService getInstance() => LocationServiceMobile();

class LocationServiceMobile implements LocationService {
  @override
  Future<void> requestLocationPermission(
      Function(double?, double?) updateMapLocation) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Logger.logDebug('Position recovered: $position');
      updateMapLocation(position.latitude, position.longitude);
    } catch (e) {
      Logger.logError('Error: $e');
    }
  }
}
