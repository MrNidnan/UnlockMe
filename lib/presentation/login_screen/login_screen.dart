import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../data/models/loginDeviceAuth/post_login_device_auth_req.dart';
import '../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/login_controller.dart'; // ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key})
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
        body: Center(
          child: SingleChildScrollView(
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
                    vertical: 83.v,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage3TracedGreen900,
                        height: 50.v,
                        width: 244.h,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 26.h),
                      ),
                      Spacer(),
                      _buildEmail(),
                      SizedBox(height: 11.v),
                      _buildEye(),
                      SizedBox(height: 9.v),
                      _buildRecordarMisDato(),
                      SizedBox(height: 11.v),
                      _buildReply(),
                      SizedBox(height: 38.v),
                      _buildEntrar(),
                      SizedBox(height: 13.v),
                      _buildRegistrarse(),
                      SizedBox(height: 23.v),
                      GestureDetector(
                        onTap: () {
                          navigateToRecoverPwd();
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
      borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
    );
  }

  /// Section Widget
  Widget _buildEye() {
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
            margin: EdgeInsets.fromLTRB(30.h, 15.v, 10.h, 15.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgEye,
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
        borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildRecordarMisDato() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 18.h),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_recordar_mis_datos".tr,
            value: controller.recordarMisDato.value,
            padding: EdgeInsets.symmetric(vertical: 3.v),
            onChange: (value) {
              controller.recordarMisDato.value = value;
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildReply() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 18.h),
        child: Obx(
          () => CustomCheckboxButton(
            alignment: Alignment.centerLeft,
            text: "msg_acepto_la_pol_tica".tr,
            value: controller.reply.value,
            padding: EdgeInsets.symmetric(vertical: 3.v),
            textStyle: CustomTextStyles.bodySmallRubik,
            onChange: (value) {
              controller.reply.value = value;
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
      onPressed: () {
        callAuth();
      },
    );
  }

  /// Section Widget
  Widget _buildRegistrarse() {
    return CustomOutlinedButton(
      width: 150.h,
      text: "lbl_registrarse".tr,
      onPressed: () {
        navigateToRegister();
      },
    );
  }

  /// calls the [https://nodedemo.dhiwise.co/device/auth/login] API
  ///
  /// It has [PostLoginDeviceAuthReq] as a parameter which will be passed as a API request body
  /// If the call is successful, the function calls the `_onCallAuthSuccess()` function.
  /// If the call fails, the function calls the `_onCallAuthError()` function.
  ///
  /// Throws a `NoInternetException` if there is no internet connection.
  Future<void> callAuth() async {
    PostLoginDeviceAuthReq postLoginDeviceAuthReq = PostLoginDeviceAuthReq();
    try {
      await controller.callLoginDeviceAuth(
        postLoginDeviceAuthReq.toJson(),
      );
      _onCallAuthSuccess();
    } on PostLoginDeviceAuthResp {
      _onCallAuthError();
    } on NoInternetException catch (e) {
      Get.rawSnackbar(message: e.toString());
    } catch (e) {}
  }

  /// Navigates to the mapaScreen when the action is triggered.
  void _onCallAuthSuccess() {
    Get.toNamed(
      AppRoutes.mapaScreen,
    );
  }

  /// Displays an alert dialog when the action is triggered.
  /// This function is typically called in response to a API call. It retrieves
  /// the `message` data from the `PostLoginDeviceAuthResp`
  /// object in the `controller` using the `message` field.
  void _onCallAuthError() {
    Get.defaultDialog(
        onConfirm: () => Get.back(),
        title: 'Authentication Error',
        middleText:
            controller.postLoginDeviceAuthResp.message.toString() ?? '');
  }

  /// Navigates to the registerScreen when the action is triggered.
  navigateToRegister() {
    Get.toNamed(
      AppRoutes.registerScreen,
    );
  }

  /// Navigates to the recuperarPwdScreen when the action is triggered.
  navigateToRecoverPwd() {
    Get.toNamed(
      AppRoutes.recuperarPwdScreen,
    );
  }
}
