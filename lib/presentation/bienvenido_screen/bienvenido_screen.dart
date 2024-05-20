import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import '../../core/app_export.dart';
import '../../domain/googleauth/google_auth_helper.dart';
import '../../routes/navigation_args.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/bienvenido_controller.dart'; // ignore_for_file: must_be_immutable

class BienvenidoScreen extends GetWidget<BienvenidoController> {
  const BienvenidoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    SizeUtils.setScreenSize(MediaQuery.of(context), MediaQuery.of(context).orientation);
    final screenHeight = SizeUtils.height;
    final screenWidth = SizeUtils.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildWelcomeColumn(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.01),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl_bienvenido2".tr,
                        style: theme.textTheme.headlineLarge,
                      ),
                      TextSpan(
                        text: "\n".tr,
                        style: theme.textTheme.headlineLarge,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomElevatedButton(
                  width: screenWidth * 0.6,
                  text: "msg_contin_a_con_google".tr,
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.02),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgBuscar1,
                      height: screenHeight * 0.02,
                      width: screenHeight * 0.02,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlinePrimary,
                  buttonTextStyle: CustomTextStyles.titleMediumManrope,
                  onPressed: () {
                    signInWithGoogle();
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "lbl".tr,
                  style: CustomTextStyles.titleMediumManrope,
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomElevatedButton(
                  width: screenWidth * 0.6,
                  text: "msg_ingresar_con_email".tr,
                  buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                  buttonTextStyle: CustomTextStyles.titleMediumManrope,
                  onPressed: () {
                    onTapIngresarcon();
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "msg_selecciona_un_idioma".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer,
                ),
                SizedBox(height: screenHeight * 0.03),
                GestureDetector(
                  onTap: () {
                    onTapTxtYatienescuenta();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "msg_ya_tienes_cuenta2".tr,
                          style: CustomTextStyles.bodySmallPrimaryContainer10,
                        ),
                        TextSpan(
                          text: "lbl_registrarse".tr,
                          style: CustomTextStyles.labelMediumPrimaryContainer
                              .copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: screenHeight * 0.07),
                Text(
                  "lbl_versi_n_2_0".tr,
                  style: CustomTextStyles.bodySmall10,
                ),
                SizedBox(height: screenHeight * 0.01)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeColumn(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: screenHeight * 0.08,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: screenHeight * 0.1),
          CustomImageView(
            imagePath: ImageConstant.imgImage3Traced,
            height: screenHeight * 0.06,
            width: screenWidth * 0.6,
          )
        ],
      ),
    );
  }

  signInWithGoogle() async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
        onSuccessGoogleAuthResponse(googleUser);
      } else {
        Get.snackbar('Error', 'user data is empty');
      }
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  onSuccessGoogleAuthResponse(GoogleSignInAccount googleUser) {
    Get.toNamed(AppRoutes.mapaScreen, arguments: {
      NavigationArgs.userPhoto: googleUser.photoUrl,
      NavigationArgs.userMail: googleUser.email
    });
  }

  onTapIngresarcon() {
    Get.toNamed(
      AppRoutes.loginScreen,
    );
  }

  onTapTxtYatienescuenta() {
    Get.toNamed(
      AppRoutes.registerScreen,
    );
  }
}
