import '../../../core/app_export.dart';
import '../controller/pop_up_bluetooth_out_of_range_controller.dart';

/// A binding class for the PopUpBluetoothOutOfRangeScreen.
///
/// This class ensures that the PopUpBluetoothOutOfRangeController is created when the
/// PopUpBluetoothOutOfRangeScreen is first loaded.
class PopUpBluetoothOutOfRangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopUpBluetoothOutOfRangeController());
  }
}
