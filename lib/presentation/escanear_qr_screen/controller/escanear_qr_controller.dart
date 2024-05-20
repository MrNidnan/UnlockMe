import '../../../core/app_export.dart';
import '../models/escanear_qr_model.dart';

/// A controller class for the EscanearQrScreen.
///
/// This class manages the state of the EscanearQrScreen, including the
/// current escanearQrModelObj
class EscanearQrController extends GetxController {
  Rx<EscanearQrModel> escanearQrModelObj = EscanearQrModel().obs;
}
