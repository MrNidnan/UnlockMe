import '../../../core/app_export.dart';
import '../controller/recuperar_pwd_controller.dart';

/// A binding class for the RecuperarPwdScreen.
///
/// This class ensures that the RecuperarPwdController is created when the
/// RecuperarPwdScreen is first loaded.
class RecuperarPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecuperarPwdController());
  }
}
