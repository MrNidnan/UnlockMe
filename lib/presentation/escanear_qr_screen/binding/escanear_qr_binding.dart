import '../../../core/app_export.dart';
import '../controller/escanear_qr_controller.dart';

/// A binding class for the EscanearQrScreen.
///
/// This class ensures that the EscanearQrController is created when the
/// EscanearQrScreen is first loaded.
class EscanearQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EscanearQrController());
  }
}
