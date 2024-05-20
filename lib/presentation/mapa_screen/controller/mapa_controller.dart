import '../../../core/app_export.dart';
import '../../../routes/navigation_args.dart';
import '../models/mapa_model.dart';

/// A controller class for the MapaScreen.
///
/// This class manages the state of the MapaScreen, including the
/// current mapaModelObj
class MapaController extends GetxController {
  var userPhoto = Get.arguments[NavigationArgs.userPhoto];

  var userMail = Get.arguments[NavigationArgs.userMail];

  Rx<MapaModel> mapaModelObj = MapaModel().obs;
}
