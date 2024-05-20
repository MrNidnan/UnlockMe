import '../../../core/app_export.dart';
import '../controller/mapa_controller.dart';

/// A binding class for the MapaScreen.
///
/// This class ensures that the MapaController is created when the
/// MapaScreen is first loaded.
class MapaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapaController());
  }
}
