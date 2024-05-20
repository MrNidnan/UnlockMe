import '../../../core/app_export.dart';
import '../controller/bienvenido_controller.dart';

/// A binding class for the BienvenidoScreen.
///
/// This class ensures that the BienvenidoController is created when the
/// BienvenidoScreen is first loaded.
class BienvenidoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BienvenidoController());
  }
}
