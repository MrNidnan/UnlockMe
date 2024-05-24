import 'package:UnlockMe/core/services/location_service.dart';
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

  MapaController() : locationService = LocationService();

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermission();
    fetchBikeCoordinates();
  }

  void updateMapLocation(double? latitude, double? longitude) {
    if ((latitude == null || longitude == null) && currentPosition.value == null) {
      currentPosition.value = defaultPostion;
      return;
    }
    currentPosition.value = LatLng(latitude!, longitude!);
  }

  Future<void> fetchBikeCoordinates() async {
    final dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> bikes = await dbHelper.getBikes();
    for (var bike in bikes) {
      bikeMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(bike['latitude'], bike['longitude']),
          
          child: 
          GestureDetector(
            onTap: () {
              navigateToBikeDetails(bike);
            },
            child: const Icon(
            Icons.pedal_bike,
            color: Colors.blue,
            size: 40.0,
          ),
        ),
        )
      );
    }
  }

  Future<void> _requestLocationPermission() async {
    await locationService.requestLocationPermission((double? latitude, double? longitude) {
      updateMapLocation(latitude, longitude);
    });
  }

  void navigateToBikeDetails(Map<String, dynamic> bike) {
  print(bike);
  Get.toNamed(
    AppRoutes.pantallaReserva,
    arguments: {
      'bikeId': bike['id'],
      'latitude': bike['latitude'],
      'longitude': bike['longitude'],
      'batteryLife': bike['battery_life'],
    },
  );
  }
}


