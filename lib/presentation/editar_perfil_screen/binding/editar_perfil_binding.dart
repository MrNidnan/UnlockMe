import '../../../core/app_export.dart';
import '../controller/editar_perfil_controller.dart';

/// A binding class for the EditarPerfilScreen.
///
/// This class ensures that the EditarPerfilController is created when the
/// EditarPerfilScreen is first loaded.
class EditarPerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditarPerfilController());
  }
}
