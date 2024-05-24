
/// This class defines the variables used in the [pantalla_reserva_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PantallaReservaModel {  
  final int bikeId;
  final double latitude;
  final double longitude;
  final int batteryLife;
  bool isReserved;
  DateTime? endsAt;

  PantallaReservaModel({
    required this.bikeId,
    required this.latitude,
    required this.longitude,
    required this.batteryLife,
    this.isReserved = false,
    this.endsAt,
  });
}
