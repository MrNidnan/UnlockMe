import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_button.dart';
import '../../widgets/custom_icon_button.dart';
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
        bottomNavigationBar: _buildBottomAppBar(),
        floatingActionButton: CustomFloatingButton(
          height: 35,
          width: 35,
          child: CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 17.5.v,
            width: 17.5.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  /// Section Widget
  Widget _buildBottomAppBar() {
    return SizedBox(
      child: SizedBox(
        height: 95.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 21.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 42.h,
                  vertical: 6.v,
                ),
                decoration: AppDecoration.fillGray30066.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 28.h,
                        top: 4.v,
                        bottom: 5.v,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconButton(
                            height: 35.adaptSize,
                            width: 35.adaptSize,
                            padding: EdgeInsets.all(6.h),
                            child: CustomImageView(
                              imagePath:
                                  ImageConstant.imgLinkedinErrorcontainer,
                            ),
                          ),
                          SizedBox(height: 3.v),
                          Text(
                            "lbl_mapa".tr,
                            style: CustomTextStyles.labelLargeBluegray100_1,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomFloatingButton(
                            height: 35,
                            width: 35,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgSearch,
                              height: 17.5.v,
                              width: 17.5.h,
                            ),
                          ),
                          SizedBox(height: 7.v),
                          Text(
                            "lbl_configuraci_n".tr,
                            style: theme.textTheme.labelLarge,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomFloatingButton(
              height: 58,
              width: 58,
              backgroundColor: appTheme.blueGray100,
              alignment: Alignment.topCenter,
              child: CustomImageView(
                imagePath: ImageConstant.imgProfile,
                height: 29.0.v,
                width: 29.0.h,
              ),
            )
          ],
        ),
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
