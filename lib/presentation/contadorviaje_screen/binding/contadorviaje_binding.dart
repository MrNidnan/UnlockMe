import '../../../core/app_export.dart';
import '../controller/contadorviaje_controller.dart';

/// A binding class for the ContadorviajeScreen.
///
/// This class ensures that the ContadorviajeController is created when the
/// ContadorviajeScreen is first loaded.
class ContadorviajeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContadorviajeController());
  }
}
