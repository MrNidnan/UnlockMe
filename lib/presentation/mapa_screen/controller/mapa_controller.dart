import 'package:UnlockMe/core/services/location_service.dart';
import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../core/app_export.dart';
import '../models/mapa_model.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class MapaController extends GetxController with WidgetsBindingObserver {
  //var userPhoto = Get.arguments[NavigationArgs.userPhoto];

  //var userMail = Get.arguments[NavigationArgs.userMail];
  Rx<MapaModel> mapaModelObj = MapaModel().obs;

  final defaultPostion = LatLng(41.3851, 2.1734);
  final LocationService locationService;
  final dbHelper = DatabaseHelper();
  Timer? _timer;

  MapaController() : locationService = LocationService();

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    //_startFetchingBikeCoordinates();
  }

  // Called once the widget is fully rendered and interactive.
  @override
  void onReady() {
    super.onReady();
    updateMap();
  }

  @override
  void onClose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    super.onClose();
  }

  // Called when the app is resumed from background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateMap();
    }
  }

  void updateMarkers(List<Bike> bikes) {
    mapaModelObj.value.markers.clear();
    mapaModelObj.value.markers.value = bikes.map((bike) {
      print('BikeStatus:${bike.status}');
      return Marker(
        point: LatLng(bike.latitude, bike.longitude),
        width: 80,
        height: 80,
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
      );
    }).toList();
    if (mapaModelObj.value.currentPosition != null) {
      mapaModelObj.value.markers.add(Marker(
        point: mapaModelObj.value.currentPosition.value!,
        width: 80,
        height: 80,
        child: Icon(
          Icons.person_pin_circle_outlined,
          color: Color.fromARGB(255, 235, 215, 38),
          size: 40.0,
        ),
      ));
    }
    mapaModelObj.refresh();
  }

  void updateMap() async {
    await _requestLocationPermission();

    var bikes = await fetchBikeCoordinates();
    updateMarkers(bikes);
    update(); //refresh the UI
  }

  void updateMapLocation(double? latitude, double? longitude) {
    Logger.logDebug(
        ' called update map location Latitude: $latitude, Longitude: $longitude');
    if ((latitude == null || longitude == null) &&
        mapaModelObj.value.currentPosition.value == null) {
      mapaModelObj.value.currentPosition.value = defaultPostion;
      return;
    }
    mapaModelObj.value.currentPosition.value = LatLng(latitude!, longitude!);
  }

  Future<List<Bike>> fetchBikeCoordinates() async {
    return await dbHelper.getUserBikes();
  }

  Future<void> _requestLocationPermission() async {
    await locationService
        .requestLocationPermission((double? latitude, double? longitude) {
      updateMapLocation(latitude, longitude);
    });
  }

  void navigateToBikeDetails(Bike bike) {
    Logger.logDebug(bike);
    Get.toNamed(
      AppRoutes.pantallaReserva,
      arguments: {
        'bike': bike,
      },
    )?.then((value) async {
      //Make sure map is updated when comming back from bike details
      updateMap();
    });
    ;
  }
}
