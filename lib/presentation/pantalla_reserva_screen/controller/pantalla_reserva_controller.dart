import '../../../core/app_export.dart';
import '../models/pantalla_reserva_model.dart';

/// A controller class for the PantallaReservaScreen.
///
/// This class manages the state of the PantallaReservaScreen, including the
/// current pantallaReservaModelObj
class PantallaReservaController extends GetxController {
  Rx<PantallaReservaModel> pantallaReservaModelObj = PantallaReservaModel().obs;
}
