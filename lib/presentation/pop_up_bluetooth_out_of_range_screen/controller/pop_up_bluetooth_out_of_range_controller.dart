import '../../../core/app_export.dart';
import '../models/pop_up_bluetooth_out_of_range_model.dart';

/// A controller class for the PopUpBluetoothOutOfRangeScreen.
///
/// This class manages the state of the PopUpBluetoothOutOfRangeScreen, including the
/// current popUpBluetoothOutOfRangeModelObj
class PopUpBluetoothOutOfRangeController extends GetxController {
  Rx<PopUpBluetoothOutOfRangeModel> popUpBluetoothOutOfRangeModelObj =
      PopUpBluetoothOutOfRangeModel().obs;
}
