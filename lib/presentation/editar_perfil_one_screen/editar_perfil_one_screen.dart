import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/editar_perfil_one_controller.dart'; // ignore_for_file: must_be_immutable

class EditarPerfilOneScreen extends GetWidget<EditarPerfilOneController> {
  const EditarPerfilOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 28.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 41.v),
                    padding: EdgeInsets.symmetric(horizontal: 21.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage3Traced,
                          height: 21.v,
                          width: 103.h,
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(height: 41.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 7.h),
                            child: Text(
                              "lbl_configuraci_n".tr,
                              style: CustomTextStyles.titleMediumBold_1,
                            ),
                          ),
                        ),
                        SizedBox(height: 23.v),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 110.h),
                          padding: EdgeInsets.all(6.h),
                          decoration: AppDecoration.fillBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder56,
                          ),
                          child: Container(
                            height: 99.adaptSize,
                            width: 99.adaptSize,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.h,
                              vertical: 42.v,
                            ),
                            decoration: AppDecoration.fillGray400,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgCamera,
                              height: 13.v,
                              width: 16.h,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.v),
                        _buildGeneral(),
                        SizedBox(height: 17.v),
                        _buildLanguage(),
                        SizedBox(height: 17.v),
                        _buildAge(),
                        SizedBox(height: 17.v),
                        _buildGender(),
                        SizedBox(height: 17.v),
                        _buildCity(),
                        SizedBox(height: 42.v),
                        CustomElevatedButton(
                          width: 150.h,
                          text: "lbl_guardar".tr,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumGray80001,
                          onPressed: () {
                            onTapGuardar();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGeneral() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_nombre".tr,
              style: CustomTextStyles.labelLargeBluegray100,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: CustomTextFormField(
              controller: controller.edittextController,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLanguage() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_email".tr,
              style: CustomTextStyles.labelLargeBluegray100,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: CustomTextFormField(
              controller: controller.emailController,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAge() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_edad".tr,
              style: CustomTextStyles.labelLargeBluegray100,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: CustomTextFormField(
              controller: controller.edittextoneController,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGender() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_sexo".tr,
              style: CustomTextStyles.labelLargeBluegray100,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: CustomTextFormField(
              controller: controller.edittexttwoController,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCity() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              "lbl_ciudad".tr,
              style: CustomTextStyles.labelLargeBluegray100,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: CustomTextFormField(
              controller: controller.edittextthreeController,
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the editarPerfilScreen when the action is triggered.
  onTapGuardar() {
    Get.toNamed(
      AppRoutes.editarPerfilScreen,
    );
  }
}
