import 'package:UnlockMe/core/services/location_service.dart';
import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../core/app_export.dart';
import '../models/mapa_model.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class MapaController extends GetxController {
  //var userPhoto = Get.arguments[NavigationArgs.userPhoto];

  //var userMail = Get.arguments[NavigationArgs.userMail];
  Rx<MapaModel> mapaModelObj = MapaModel().obs;
  var currentPosition = Rx<LatLng?>(null);
  var bikeMarkers = <Marker>[].obs;
  final defaultPostion = LatLng(41.3851, 2.1734);
  final LocationService locationService;
  final dbHelper = DatabaseHelper();
  Timer? _timer;

  MapaController() : locationService = LocationService();

  @override
  void onInit() async {
    super.onInit();
    _requestLocationPermission();
    await fetchBikeCoordinates();
    //_startFetchingBikeCoordinates();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateMap() async {
    await _requestLocationPermission();
    update(); //refresh the UI
  }

  void updateMapLocation(double? latitude, double? longitude) {
    if ((latitude == null || longitude == null) &&
        currentPosition.value == null) {
      currentPosition.value = defaultPostion;
      return;
    }
    currentPosition.value = LatLng(latitude!, longitude!);
  }

  Future<void> fetchBikeCoordinates() async {
    List<Bike> bikes = await dbHelper.getUserBikes();
    bikeMarkers.clear();

    for (var bike in bikes) {
      print('BikeStatus:${bike.status}');
      bikeMarkers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(bike.latitude, bike.longitude),
        child: GestureDetector(
          onTap: () {
            navigateToBikeDetails(bike);
          },
          child: Icon(
            Icons.pedal_bike,
            color: bike.status == BikeStatus.available
                ? Colors.blue
                : Color.fromARGB(255, 233, 128, 9),
            size: 40.0,
          ),
        ),
      ));
    }
  }

  Future<void> _requestLocationPermission() async {
    await locationService
        .requestLocationPermission((double? latitude, double? longitude) {
      updateMapLocation(latitude, longitude);
    });
  }

  void navigateToBikeDetails(Bike bike) {
    print(bike);
    Get.toNamed(
      AppRoutes.pantallaReserva,
      arguments: {
        'bike': bike,
      },
    )?.then((value) async {
      // Restart fetching bike coordinates when coming back
      await fetchBikeCoordinates();
    });
    ;
  }

  void _startFetchingBikeCoordinates() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetchBikeCoordinates();
    });
  }
}
