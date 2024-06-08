import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/bienvenido_controller.dart'; // ignore_for_file: must_be_immutable

class BienvenidoScreen extends GetWidget<BienvenidoController> {
  const BienvenidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildWelcomeColumn(),
                SizedBox(height: SizeUtils.height * 0.01),
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
                SizedBox(height: SizeUtils.height * 0.01),
                CustomElevatedButton(
                  width: SizeUtils.width * 0.6,
                  text: "msg_contin_a_con_google".tr,
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: SizeUtils.width * 0.02),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgBuscar1,
                      height: SizeUtils.height * 0.02,
                      width: SizeUtils.height * 0.02,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlinePrimary,
                  buttonTextStyle: CustomTextStyles.titleMediumManrope,
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                ),
                SizedBox(height: SizeUtils.height * 0.01),
                Text(
                  "lbl".tr,
                  style: CustomTextStyles.titleMediumManrope,
                ),
                SizedBox(height: SizeUtils.height * 0.01),
                CustomElevatedButton(
                  width: SizeUtils.width * 0.6,
                  text: "msg_ingresar_con_email".tr,
                  buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                  buttonTextStyle: CustomTextStyles.titleMediumManrope,
                  onPressed: () {
                    onTapIngresarcon();
                  },
                ),
                SizedBox(height: SizeUtils.height * 0.01),
                Text(
                  "msg_selecciona_un_idioma".tr,
                  style: CustomTextStyles.bodySmallPrimaryContainer,
                ),
                SizedBox(height: SizeUtils.height * 0.03),
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
                SizedBox(height: SizeUtils.height * 0.07),
                Text(
                  "lbl_versi_n_2_0".tr,
                  style: CustomTextStyles.bodySmall10,
                ),
                SizedBox(height: SizeUtils.height * 0.01)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeColumn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.width * 0.1,
        vertical: SizeUtils.height * 0.08,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: SizeUtils.height * 0.1),
          CustomImageView(
            imagePath: ImageConstant.imgImage3Traced,
            height: SizeUtils.height * 0.06,
            width: SizeUtils.width * 0.6,
          )
        ],
      ),
    );
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
