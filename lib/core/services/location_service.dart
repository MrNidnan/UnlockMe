// location_service.dart
// Conditional imports depending on the platform
 import 'package:UnlockMe/core/services/location_service_helper.dart' 
   if (dart.library.html) './location_service_web.dart' 
   if (dart.library.io) './location_service_mobile.dart';


typedef LocationServiceCallback = void Function(double? latitude, double? longitude);


abstract class LocationService {

  factory LocationService() => getInstance();

  Future<void> requestLocationPermission(LocationServiceCallback updateMapLocation);
  
}
