import '../../../core/storage/contracts/bike.dart';

/// This class defines the variables used in the [pantalla_reserva_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PantallaReservaModel {
  final Bike bike;
  bool isReserved;
  DateTime? endsAt;

  PantallaReservaModel({
    required this.bike,
    this.isReserved = false,
    this.endsAt,
  });
}
