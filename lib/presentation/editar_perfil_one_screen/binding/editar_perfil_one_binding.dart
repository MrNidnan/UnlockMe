import '../../../core/app_export.dart';
import '../controller/editar_perfil_one_controller.dart';

/// A binding class for the EditarPerfilOneScreen.
///
/// This class ensures that the EditarPerfilOneController is created when the
/// EditarPerfilOneScreen is first loaded.
class EditarPerfilOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditarPerfilOneController());
  }
}
