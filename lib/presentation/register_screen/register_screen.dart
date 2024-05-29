import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/register_controller.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends GetWidget<RegisterController> {
  RegisterScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils.setScreenSize(
        MediaQuery.of(context), MediaQuery.of(context).orientation);

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
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.width * 0.08,
                  vertical: SizeUtils.height * 0.05,
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage3TracedGreen900,
                      height: SizeUtils.height * 0.06,
                      width: SizeUtils.width * 0.65,
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: SizeUtils.width * 0.04),
                    ),
                    Spacer(),
                    _buildName(),
                    SizedBox(height: SizeUtils.height * 0.01),
                    _buildEmail(),
                    SizedBox(height: SizeUtils.height * 0.01),
                    _buildPassword(),
                    SizedBox(height: SizeUtils.height * 0.01),
                    _buildConfirmPassword(),
                    SizedBox(height: SizeUtils.height * 0.01),
                    _buildRecordarMisDatos(),
                    SizedBox(height: SizeUtils.height * 0.03),
                    _buildEntrar(),
                    SizedBox(height: SizeUtils.height * 0.02),
                    _buildRegistrarse(),
                    SizedBox(height: SizeUtils.height * 0.03),
                    Text(
                      "msg_has_olvidado_tu".tr,
                      style:
                          CustomTextStyles.bodySmallPrimaryContainer.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: SizeUtils.height * 0.04),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return CustomTextFormField(
      controller: controller.nameOneController,
      hintText: "lbl_nombre".tr,
      borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
    );
  }

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

  Widget _buildPassword() {
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
            margin: EdgeInsets.fromLTRB(
              SizeUtils.width * 0.08,
              SizeUtils.height * 0.02,
              SizeUtils.width * 0.03,
              SizeUtils.height * 0.02,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgEyeBlueGray100,
              height: SizeUtils.height * 0.02,
              width: SizeUtils.width * 0.05,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: SizeUtils.height * 0.07,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: controller.isShowPassword.value,
        contentPadding: EdgeInsets.only(
          left: SizeUtils.width * 0.05,
          top: SizeUtils.height * 0.02,
          bottom: SizeUtils.height * 0.02,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
      ),
    );
  }

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
            margin: EdgeInsets.fromLTRB(
              SizeUtils.width * 0.08,
              SizeUtils.height * 0.02,
              SizeUtils.width * 0.03,
              SizeUtils.height * 0.02,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgEyeBlueGray100,
              height: SizeUtils.height * 0.02,
              width: SizeUtils.width * 0.05,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: SizeUtils.height * 0.07,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: controller.isShowPassword1.value,
        contentPadding: EdgeInsets.only(
          left: SizeUtils.width * 0.05,
          top: SizeUtils.height * 0.02,
          bottom: SizeUtils.height * 0.02,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL5,
      ),
    );
  }

  Widget _buildRecordarMisDatos() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: SizeUtils.width * 0.05),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_recordar_mis_datos".tr,
            value: controller.recordarMisDatos.value,
            padding: EdgeInsets.symmetric(vertical: SizeUtils.height * 0.01),
            onChange: (value) {
              controller.recordarMisDatos.value = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEntrar() {
    return CustomElevatedButton(
      width: SizeUtils.width * 0.4,
      text: "lbl_entrar".tr,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // callRegister();
          Get.toNamed(AppRoutes.bienvenidoOneScreen);
        } else {
          Get.rawSnackbar(
              message: "Please fill in all required fields correctly.");
        }
      },
    );
  }

  Widget _buildRegistrarse() {
    return CustomOutlinedButton(
      width: SizeUtils.width * 0.4,
      text: "lbl_registrarse".tr,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          controller.registerUser();
        } else {
          Get.rawSnackbar(
              message: "Please fill in all required fields correctly.");
        }
      },
    );
  }
}
