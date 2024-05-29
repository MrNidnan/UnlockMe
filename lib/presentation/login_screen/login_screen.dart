import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeUtils.setScreenSize(
        MediaQuery.of(context), MediaQuery.of(context).orientation);
    final screenHeight = SizeUtils.height;
    final screenWidth = SizeUtils.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.005),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage3TracedGreen900,
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.65,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: screenWidth * 0.07),
                      ),
                      Spacer(),
                      _buildEmail(context),
                      SizedBox(height: screenHeight * 0.01),
                      _buildEye(context),
                      SizedBox(height: screenHeight * 0.01),
                      _buildRecordarMisDato(context),
                      SizedBox(height: screenHeight * 0.01),
                      _buildReply(context),
                      SizedBox(height: screenHeight * 0.05),
                      _buildEntrar(context),
                      SizedBox(height: screenHeight * 0.02),
                      _buildRegistrarse(context),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: () {
                          controller.navigateToRecoverPwd();
                        },
                        child: Text(
                          "msg_has_olvidado_tu".tr,
                          style: CustomTextStyles.bodySmallPrimaryContainer
                              .copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
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
      borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
    );
  }

  Widget _buildEye(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        controller: controller.eyeController,
        hintText: "lbl_contrase_a".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword.value = !controller.isShowPassword.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(
              SizeUtils.marginMedium(),
              SizeUtils.marginSmall(),
              SizeUtils.marginMedium(),
              SizeUtils.marginSmall(),
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgEye,
              height: SizeUtils.textBoxHeight() * 0.3,
              width: SizeUtils.textBoxHeight() * 0.45,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: SizeUtils.textBoxHeight() * 1.1,
        ),
        validator: (value) {
          if (!isValidPassword(value, isRequired: true)) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: controller.isShowPassword.value,
        contentPadding: EdgeInsets.only(
          left: SizeUtils.paddingMedium(),
          top: SizeUtils.paddingSmall(),
          bottom: SizeUtils.paddingSmall(),
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
      ),
    );
  }

  Widget _buildRecordarMisDato(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: SizeUtils.marginMedium()),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_recordar_mis_datos".tr,
            value: controller.recordarMisDato.value,
            padding: EdgeInsets.symmetric(vertical: SizeUtils.paddingSmall()),
            onChange: (value) {
              controller.recordarMisDato.value = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReply(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: SizeUtils.marginMedium()),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_acepto_la_pol_tica".tr,
            value: controller.reply.value,
            padding: EdgeInsets.symmetric(vertical: SizeUtils.paddingSmall()),
            textStyle: CustomTextStyles.bodySmallRubik,
            onChange: (value) {
              controller.reply.value = value;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEntrar(BuildContext context) {
    return CustomElevatedButton(
      width: SizeUtils.width * 0.4,
      text: "lbl_entrar".tr,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          controller.callAuthMock();
        } else {
          Get.rawSnackbar(
              message: "Please fill in all required fields correctly.");
        }
      },
    );
  }

  Widget _buildRegistrarse(BuildContext context) {
    return CustomOutlinedButton(
      width: SizeUtils.width * 0.4,
      text: "lbl_registrarse".tr,
      onPressed: () {
        controller.navigateToRegister();
      },
    );
  }
}
