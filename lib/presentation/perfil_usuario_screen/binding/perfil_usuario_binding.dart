import '../../../core/app_export.dart';
import '../controller/perfil_usuario_controller.dart';

/// A binding class for the PerfilUsuarioScreen.
///
/// This class ensures that the PerfilUsuarioController is created when the
/// PerfilUsuarioScreen is first loaded.
class PerfilUsuarioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerfilUsuarioController());
  }
}
