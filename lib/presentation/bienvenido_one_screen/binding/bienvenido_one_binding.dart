import '../../../core/app_export.dart';
import '../controller/bienvenido_one_controller.dart';

/// A binding class for the BienvenidoOneScreen.
///
/// This class ensures that the BienvenidoOneController is created when the
/// BienvenidoOneScreen is first loaded.
class BienvenidoOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BienvenidoOneController());
  }
}
