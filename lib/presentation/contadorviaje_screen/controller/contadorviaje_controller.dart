import '../../../core/app_export.dart';
import '../models/contadorviaje_model.dart';

/// A controller class for the ContadorviajeScreen.
///
/// This class manages the state of the ContadorviajeScreen, including the
/// current contadorviajeModelObj
class ContadorviajeController extends GetxController {
  Rx<ContadorviajeModel> contadorviajeModelObj = ContadorviajeModel().obs;
}
