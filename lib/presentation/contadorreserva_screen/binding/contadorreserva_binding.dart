import '../../../core/app_export.dart';
import '../controller/contadorreserva_controller.dart';

/// A binding class for the ContadorreservaScreen.
///
/// This class ensures that the ContadorreservaController is created when the
/// ContadorreservaScreen is first loaded.
class ContadorreservaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContadorreservaController());
  }
}
