import '../../../core/app_export.dart';
import '../controller/register_controller.dart';

/// A binding class for the RegisterScreen.
///
/// This class ensures that the RegisterController is created when the
/// RegisterScreen is first loaded.
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
