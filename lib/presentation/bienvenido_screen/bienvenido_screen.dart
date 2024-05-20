import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildWelcomeColumn(),
              SizedBox(height: 24.v),
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
              SizedBox(height: 23.v),
              CustomElevatedButton(
                width: 239.h,
                text: "msg_contin_a_con_google".tr,
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 8.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgBuscar1,
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                  ),
                ),
                buttonStyle: CustomButtonStyles.outlinePrimary,
                buttonTextStyle: CustomTextStyles.titleMediumManrope,
                onPressed: () {
                  signInWithGoogle();
                },
              ),
              SizedBox(height: 30.v),
              Text(
                "lbl".tr,
                style: CustomTextStyles.titleMediumManrope,
              ),
              SizedBox(height: 9.v),
              CustomElevatedButton(
                width: 239.h,
                text: "msg_ingresar_con_email".tr,
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                buttonTextStyle: CustomTextStyles.titleMediumManrope,
                onPressed: () {
                  onTapIngresarcon();
                },
              ),
              SizedBox(height: 16.v),
              Text(
                "msg_selecciona_un_idioma".tr,
                style: CustomTextStyles.bodySmallPrimaryContainer,
              ),
              SizedBox(height: 26.v),
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
              SizedBox(height: 62.v),
              Text(
                "lbl_versi_n_2_0".tr,
                style: CustomTextStyles.bodySmall10,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeColumn() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 41.h,
        vertical: 67.v,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 74.v),
          CustomImageView(
            imagePath: ImageConstant.imgImage3Traced,
            height: 50.v,
            width: 246.h,
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

  /// Navigates to the mapaScreen when the action is triggered.
  onSuccessGoogleAuthResponse(GoogleSignInAccount googleUser) {
    Get.toNamed(AppRoutes.mapaScreen, arguments: {
      NavigationArgs.userPhoto: googleUser.photoUrl,
      NavigationArgs.userMail: googleUser.email
    });
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapIngresarcon() {
    Get.toNamed(
      AppRoutes.loginScreen,
    );
  }

  /// Navigates to the registerScreen when the action is triggered.
  onTapTxtYatienescuenta() {
    Get.toNamed(
      AppRoutes.registerScreen,
    );
  }
}
