import '../../../core/app_export.dart';
import '../models/bienvenido_one_model.dart';

/// A controller class for the BienvenidoOneScreen.
///
/// This class manages the state of the BienvenidoOneScreen, including the
/// current bienvenidoOneModelObj
class BienvenidoOneController extends GetxController {
  Rx<BienvenidoOneModel> bienvenidoOneModelObj = BienvenidoOneModel().obs;

  // @override
  // void onReady() {
  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     Get.offNamed(
  //       AppRoutes.bienvenidoScreen,
  //     );
  //   });
  // }
}
