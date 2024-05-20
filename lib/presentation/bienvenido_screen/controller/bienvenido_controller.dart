import '../../../core/app_export.dart';
import '../models/bienvenido_model.dart';

/// A controller class for the BienvenidoScreen.
///
/// This class manages the state of the BienvenidoScreen, including the
/// current bienvenidoModelObj
class BienvenidoController extends GetxController {
  Rx<BienvenidoModel> bienvenidoModelObj = BienvenidoModel().obs;
}
