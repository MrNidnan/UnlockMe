import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/editar_perfil_controller.dart'; // ignore_for_file: must_be_immutable

class EditarPerfilScreen extends GetWidget<EditarPerfilController> {
  const EditarPerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 68.v),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.v),
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: Column(
                children: [
                  _buildGeneral(),
                  SizedBox(height: 16.v),
                  _buildLanguage(),
                  SizedBox(height: 18.v),
                  _buildAccount(),
                  SizedBox(height: 99.v),
                  CustomElevatedButton(
                    text: "lbl_cerrar_sesi_n".tr,
                    buttonStyle: CustomButtonStyles.fillOnSecondaryContainer,
                    buttonTextStyle: CustomTextStyles.labelLargeBluegray300,
                    onPressed: () {
                      onTapCerrarsesin();
                    },
                  ),
                  SizedBox(height: 26.v),
                  CustomElevatedButton(
                    text: "lbl_eliminar_cuenta".tr,
                    buttonStyle: CustomButtonStyles.fillOnSecondaryContainer,
                    buttonTextStyle: CustomTextStyles.labelLargeBluegray300,
                    onPressed: () {
                      onTapEliminarcuenta();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronLeft,
        margin: EdgeInsets.only(
          left: 14.h,
          right: 337.h,
        ),
        onTap: () {
          onTapChevronleftone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildGeneral() {
    return GestureDetector(
      onTap: () {
        onTapGeneral();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_configuraci_n_general".tr,
            style: CustomTextStyles.labelLargePrimaryContainer,
          ),
          SizedBox(height: 13.v),
          CustomTextFormField(
            controller: controller.editprofileoneController,
            hintText: "lbl_editar_perfil".tr,
            hintStyle: CustomTextStyles.labelLargeBluegray100Medium,
            prefix: Container(
              margin: EdgeInsets.fromLTRB(15.h, 10.v, 9.h, 10.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgSettings,
                height: 25.adaptSize,
                width: 25.adaptSize,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 45.v,
            ),
            contentPadding: EdgeInsets.only(
              top: 15.v,
              right: 30.h,
              bottom: 15.v,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_idioma".tr,
          style: CustomTextStyles.labelLargePrimaryContainer,
        ),
        SizedBox(height: 14.v),
        CustomTextFormField(
          controller: controller.englishoneController,
          hintText: "lbl_ingl_s".tr,
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "msg_configuraci_n_de".tr,
          style: CustomTextStyles.labelLargePrimaryContainer,
        ),
        SizedBox(height: 13.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 13.h,
            vertical: 14.v,
          ),
          decoration: AppDecoration.outlineBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: _buildRowCambiar(
                  changePasswordText: "lbl_cambiar_mail".tr,
                  passwordText: "msg_juanasanz_gmail_com2".tr,
                ),
              ),
              SizedBox(height: 10.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: _buildRowCambiar(
                  changePasswordText: "msg_cambiar_contarse_a".tr,
                  passwordText: "lbl4".tr,
                ),
              ),
              SizedBox(height: 2.v)
            ],
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowCambiar({
    required String changePasswordText,
    required String passwordText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            changePasswordText,
            style: CustomTextStyles.bodySmallBluegray300.copyWith(
              color: appTheme.blueGray300,
            ),
          ),
        ),
        Text(
          passwordText,
          style: CustomTextStyles.labelLargeGray30001.copyWith(
            color: appTheme.gray30001,
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapChevronleftone() {
    Get.back();
  }

  /// Navigates to the editarPerfilOneScreen when the action is triggered.
  onTapGeneral() {
    Get.toNamed(
      AppRoutes.editarPerfilOneScreen,
    );
  }

  /// Navigates to the bienvenidoScreen when the action is triggered.
  onTapCerrarsesin() {
    Get.toNamed(
      AppRoutes.bienvenidoScreen,
    );
  }

  /// Navigates to the bienvenidoOneScreen when the action is triggered.
  onTapEliminarcuenta() {
    Get.toNamed(
      AppRoutes.bienvenidoOneScreen,
    );
  }
}
