import 'package:unlockme/core/app_storage.dart';
import 'package:unlockme/domain/googleauth/google_auth_helper.dart';
import 'package:unlockme/domain/users/user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unlockme/routes/navigation_args.dart';
import '../../../core/app_export.dart';
import '../models/bienvenido_model.dart';

/// A controller class for the BienvenidoScreen.
///
/// This class manages the state of the BienvenidoScreen, including the
/// current bienvenidoModelObj
class BienvenidoController extends GetxController {
  Rx<BienvenidoModel> bienvenidoModelObj = BienvenidoModel().obs;
  late final UserService _userService;

  @override
  void onInit() {
    super.onInit();
    _userService = Get.find<UserService>();
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleAuthHelper().googleSignInProcess();
      if (googleUser != null) {
        onSuccessGoogleAuthResponse(googleUser);
      } else {
        Get.snackbar('Error', 'User data is empty');
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    }
  }

  Future<void> onSuccessGoogleAuthResponse(
      GoogleSignInAccount googleUser) async {
    // Call create user from user service
    String name = googleUser.displayName ?? "Google User";
    String email = googleUser.email;
    String password = "google_auth"; // Placeholder password for social sign-ins

    int result = await _userService
        .createUser(User(name: name, email: email, password: password));

    if (result == -1) {
      Get.snackbar('Error', "User already exists with that email!");
      return;
    }

    Get.toNamed(AppRoutes.mapaScreen, arguments: {
      NavigationArgs.userPhoto: googleUser.photoUrl,
      NavigationArgs.userMail: googleUser.email
    });
  }

  void onTapIngresarcon() {
    Get.toNamed(AppRoutes.loginScreen);
  }

  void onTapTxtYatienescuenta() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}
