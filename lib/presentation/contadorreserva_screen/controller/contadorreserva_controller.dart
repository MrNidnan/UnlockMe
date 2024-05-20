import '../../../core/app_export.dart';
import '../models/contadorreserva_model.dart';

/// A controller class for the ContadorreservaScreen.
///
/// This class manages the state of the ContadorreservaScreen, including the
/// current contadorreservaModelObj
class ContadorreservaController extends GetxController {
  Rx<ContadorreservaModel> contadorreservaModelObj = ContadorreservaModel().obs;
}
