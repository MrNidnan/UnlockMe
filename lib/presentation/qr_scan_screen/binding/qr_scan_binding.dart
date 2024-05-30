import '../../../core/app_export.dart';
import '../controller/qr_scan_controller.dart';

/// A binding class for the EscanearQrScreen.
///
/// This class ensures that the EscanearQrController is created when the
/// EscanearQrScreen is first loaded.
class QrScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrScanController());
  }
}
