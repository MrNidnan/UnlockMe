import '../../../core/app_export.dart';
import '../controller/pantalla_reserva_controller.dart';

/// A binding class for the PantallaReservaScreen.
///
/// This class ensures that the PantallaReservaController is created when the
/// PantallaReservaScreen is first loaded.
class PantallaReservaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PantallaReservaController());
  }
}
