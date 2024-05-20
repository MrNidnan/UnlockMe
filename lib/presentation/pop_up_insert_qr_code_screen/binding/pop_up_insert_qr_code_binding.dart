import '../../../core/app_export.dart';
import '../controller/pop_up_insert_qr_code_controller.dart';

/// A binding class for the PopUpInsertQrCodeScreen.
///
/// This class ensures that the PopUpInsertQrCodeController is created when the
/// PopUpInsertQrCodeScreen is first loaded.
class PopUpInsertQrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopUpInsertQrCodeController());
  }
}
