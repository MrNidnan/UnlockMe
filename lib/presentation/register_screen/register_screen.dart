import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/register_controller.dart'; // ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class RegisterScreen extends GetWidget<RegisterController> {
  RegisterScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: SizeUtils.height,
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 30.h,
                  vertical: 38.v,
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3TracedGreen900,
                      height: 50.v,
                      width: 244.h,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 14.h),
                    ),
                    Spacer(),
                    _buildNameOne(),
                    SizedBox(height: 10.v),
                    _buildEmail(),
                    SizedBox(height: 10.v),
                    _buildPasswordOne(),
                    SizedBox(height: 10.v),
                    _buildConfirmPassword(),
                    SizedBox(height: 11.v),
                    _buildRecordarMisDatos(),
                    SizedBox(height: 29.v),
                    _buildEntrar(),
                    SizedBox(height: 13.v),
                    _buildRegistrarse(),
                    SizedBox(height: 23.v),
                    Text(
                      "msg_has_olvidado_tu".tr,
                      style:
                          CustomTextStyles.bodySmallPrimaryContainer.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 31.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameOne() {
    return CustomTextFormField(
      controller: controller.nameOneController,
      hintText: "lbl_nombre".tr,
      borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
    );
  }

  /// Section Widget
  Widget _buildEmail() {
    return CustomTextFormField(
      controller: controller.emailController,
      hintText: "lbl_email".tr,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
      borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
    );
  }

  /// Section Widget
  Widget _buildPasswordOne() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.passwordOneController,
        hintText: "lbl_contrase_a".tr,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword.value = !controller.isShowPassword.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgEyeBlueGray100,
              height: 14.v,
              width: 22.h,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 45.v,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: controller.isShowPassword.value,
        contentPadding: EdgeInsets.only(
          left: 17.h,
          top: 14.v,
          bottom: 14.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmPassword() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.confirmPasswordController,
        hintText: "msg_confirmar_contrase_a".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword1.value =
                !controller.isShowPassword1.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(30.h, 14.v, 10.h, 14.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgEyeBlueGray100,
              height: 14.v,
              width: 22.h,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 45.v,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: controller.isShowPassword1.value,
        contentPadding: EdgeInsets.only(
          left: 17.h,
          top: 14.v,
          bottom: 14.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
      ),
    );
  }

  /// Section Widget
  Widget _buildRecordarMisDatos() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 18.h),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_recordar_mis_datos".tr,
            value: controller.recordarMisDatos.value,
            padding: EdgeInsets.symmetric(vertical: 3.v),
            onChange: (value) {
              controller.recordarMisDatos.value = value;
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEntrar() {
    return CustomElevatedButton(
      width: 150.h,
      text: "lbl_entrar".tr,
    );
  }

  /// Section Widget
  Widget _buildRegistrarse() {
    return CustomOutlinedButton(
      width: 150.h,
      text: "lbl_registrarse".tr,
    );
  }
}
