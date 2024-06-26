import '../../../core/app_export.dart';
import '../controller/qr_manual_controller.dart';

/// A binding class for the PopUpInsertQrCodeScreen.
///
/// This class ensures that the PopUpInsertQrCodeController is created when the
/// PopUpInsertQrCodeScreen is first loaded.
class QrManualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrManualController());
  }
}
