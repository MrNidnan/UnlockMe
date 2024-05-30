import 'package:UnlockMe/core/app_export.dart';
import 'package:UnlockMe/core/app_storage.dart';
import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:UnlockMe/core/services/location_service.dart';
import 'package:UnlockMe/core/services/travel_timer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import '../models/mapa_model.dart';

class MapaController extends GetxController with WidgetsBindingObserver {
  final _hiveService = Get.find<HiveService>();
  late ReserveTimerService _reserveTimerService;
  late TravelTimerService _travelTimerService;
  // Observing the timer state from TimerService
  RxInt get remainingTime => _reserveTimerService.remainingTime;
  RxInt get acumulateTime => _travelTimerService.accumulatedTime;
  RxBool get isReserveTimerRunning => _reserveTimerService.isRunning;
  RxBool get isTravelTimerRunning => _travelTimerService.isRunning;

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
    _reserveTimerService = Get.find<ReserveTimerService>();
    _travelTimerService = Get.find<TravelTimerService>();
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
            _navigateToBikeDetails(bike);
          },
          child: Icon(
            Icons.pedal_bike,
            color: getBikeColor(bike.status),
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
          color: appTheme.green900,
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

  void navigateFromTimer() {
    if (isReserveTimerRunning.value) {
      navigateToReserveScreen();
    } else if (isTravelTimerRunning.value) {
      navigateToContador();
    }
  }

  void navigateToReserveScreen() {
    dbHelper.getActiveReserveForUser(_hiveService.getUserId()!).then((reserve) {
      if (reserve == null) {
        Get.snackbar(
          'Error',
          'Reserve could not be loaded',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        return;
      }
      dbHelper.getBikeById(reserve.bikeId).then((bike) {
        _navigateToBikeDetails(bike);
      });
    });
  }

  void _navigateToBikeDetails(Bike bike) {
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

  void navigateToContador() {
    Get.toNamed(AppRoutes.contadorViajeScreen)?.then((value) async {
      //Make sure map is updated when comming back route deatils in case travel is cancelled
      updateMap();
    });
    ;
  }

  void navigateToQrScan() {
    Get.toNamed(AppRoutes.escanearQrScreen)?.then((value) async {
      if (_hiveService.getRouteId() != null) {
        //Make sure map is updated when comming back from qr scan with bike unlocked
        Get.snackbar(
          'Success',
          'Bike unlocked successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
        );
        updateMap();
      }
    });
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.editarPerfilOneScreen);
  }

  Color getBikeColor(String status) {
    switch (status) {
      case BikeStatus.available:
        return Colors.blue;
      case BikeStatus.inUse:
        return appTheme.green900;
      case BikeStatus.reserved:
        return Colors.orange;
      default:
        return Colors.black; // Color for other statuses
    }
  }

  String getTimerButtonLabel() {
    if (isReserveTimerRunning.value) {
      return 'lbl_reserve_time_left ${getTimerTime()}'.tr;
    } else if (isTravelTimerRunning.value) {
      return 'lbl_route_time ${getTimerTime()}'.tr;
    }
    return 'Timer'; // Default case
  }

  String getTimerTime() {
    if (isReserveTimerRunning.value) {
      final time = remainingTime.value;
      final minutes = (time ~/ 60).toString().padLeft(2, '0');
      final seconds = (time % 60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    } else if (isTravelTimerRunning.value) {
      final time = acumulateTime.value;
      final hours = (time ~/ 3600).toString().padLeft(2, '0');
      final minutes = ((time % 3600) ~/ 60).toString().padLeft(2, '0');
      final seconds = (time % 60).toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds';
    }

    return '00:00'; // Default case
  }
}
