import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/recuperar_pwd_controller.dart';
// ignore_for_file: must_be_immutable

class RecuperarPwdScreen extends GetWidget<RecuperarPwdController> {
  RecuperarPwdScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        appBar: _buildAppbar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 30.h,
                vertical: 47.v,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 171.h,
                    child: Text(
                      "msg_recupera_tu_contarse_a".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.headlineLargePrimaryContainer
                          .copyWith(
                        height: 1.19,
                      ),
                    ),
                  ),
                  SizedBox(height: 46.v),
                  Container(
                    width: 283.h,
                    margin: EdgeInsets.only(
                      left: 11.h,
                      right: 20.h,
                    ),
                    child: Text(
                      "msg_para_poder_recuperar".tr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        height: 1.39,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.v),
                  CustomTextFormField(
                    controller: controller.emailController,
                    hintText: "lbl_email".tr,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          (!isValidEmail(value, isRequired: true))) {
                        return "err_msg_please_enter_valid_email".tr;
                      }
                      return null;
                    },
                    borderDecoration:
                        TextFormFieldStyleHelper.outlineBlueGrayTL5,
                  ),
                  SizedBox(height: 10.v),
                  CustomTextFormField(
                    controller: controller.mobileoneController,
                    hintText: "lbl_m_vil".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (!isValidPassword(value, isRequired: true)) {
                        return "err_msg_please_enter_valid_password".tr;
                      }
                      return null;
                    },
                    obscureText: true,
                    borderDecoration:
                        TextFormFieldStyleHelper.outlineBlueGrayTL5,
                  ),
                  SizedBox(height: 76.v),
                  CustomElevatedButton(
                    width: 150.h,
                    text: "lbl_enviar".tr,
                  ),
                  SizedBox(height: 5.v)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
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

  /// Navigates to the previous screen.
  onTapChevronleftone() {
    Get.back();
  }
}
