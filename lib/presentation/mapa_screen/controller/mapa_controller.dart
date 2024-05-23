import 'package:UnlockMe/core/storage/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../core/app_export.dart';
import '../models/mapa_model.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class MapaController extends GetxController {

  //var userPhoto = Get.arguments[NavigationArgs.userPhoto];

  //var userMail = Get.arguments[NavigationArgs.userMail];
  Rx<MapaModel> mapaModelObj = MapaModel().obs;
  var currentPosition = Rx<LatLng?>(null);
  var bikeMarkers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermission();
    fetchBikeCoordinates();

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
          child: Icon(
            Icons.pedal_bike,
            color: Colors.blue,
            size: 40.0,
          ),
        ),
      );
    }
  }

  Future<void> _requestLocationPermission() async {
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition.value = LatLng(position.latitude, position.longitude);
  }

  void updateMapLocation(Position position) {
    currentPosition.value = LatLng(position.latitude, position.longitude);
  }
}


