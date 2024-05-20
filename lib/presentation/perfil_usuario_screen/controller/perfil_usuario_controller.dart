import '../../../core/app_export.dart';
import '../models/perfil_usuario_model.dart';

/// A controller class for the PerfilUsuarioScreen.
///
/// This class manages the state of the PerfilUsuarioScreen, including the
/// current perfilUsuarioModelObj
class PerfilUsuarioController extends GetxController {
  Rx<PerfilUsuarioModel> perfilUsuarioModelObj = PerfilUsuarioModel().obs;
}
