import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/escanear_qr_controller.dart'; // ignore_for_file: must_be_immutable

class EscanearQrScreen extends GetWidget<EscanearQrController> {
  const EscanearQrScreen({Key? key})
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
              SizedBox(
                height: 495.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.h,
                          vertical: 34.v,
                        ),
                        decoration: AppDecoration.fillGray300.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBL50,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.v),
                            DottedBorder(
                              color: theme.colorScheme.primaryContainer,
                              padding: EdgeInsets.only(
                                left: 3.h,
                                top: 3.v,
                                right: 3.h,
                                bottom: 3.v,
                              ),
                              strokeWidth: 3.h,
                              radius: Radius.circular(50),
                              borderType: BorderType.RRect,
                              dashPattern: [210, 270],
                              child: Container(
                                height: 366.v,
                                width: 315.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    50.h,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.h,
                          vertical: 16.v,
                        ),
                        decoration:
                            AppDecoration.fillOnSecondaryContainer.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBL50,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowLeftTeal900,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              onTap: () {
                                onTapImgArrowleftone();
                              },
                            ),
                            SizedBox(height: 38.v),
                            Container(
                              height: 366.v,
                              width: 332.h,
                              margin: EdgeInsets.only(left: 7.h),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgQrcodeGenerado,
                                    height: 332.adaptSize,
                                    width: 332.adaptSize,
                                    alignment: Alignment.center,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: DottedBorder(
                                      color: theme.colorScheme.primaryContainer,
                                      padding: EdgeInsets.only(
                                        left: 3.h,
                                        top: 3.v,
                                        right: 3.h,
                                        bottom: 3.v,
                                      ),
                                      strokeWidth: 3.h,
                                      radius: Radius.circular(50),
                                      borderType: BorderType.RRect,
                                      dashPattern: [210, 270],
                                      child: Container(
                                        height: 366.v,
                                        width: 315.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 34.v)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 26.v),
              CustomElevatedButton(
                width: 205.h,
                text: "msg_escanea_c_digo_qr".tr,
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
                onPressed: () {
                  onTapEscaneacdigo();
                },
              ),
              SizedBox(height: 1.v),
              SizedBox(
                width: 14.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl3".tr,
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                      TextSpan(
                        text: "\n\n\n".tr,
                        style: CustomTextStyles.headlineMediumArchivo,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.v),
              GestureDetector(
                onTap: () {
                  onTapTxtIntroduceeln();
                },
                child: Text(
                  "msg_introduce_el_n_mero".tr,
                  style: CustomTextStyles.titleMediumBold,
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }

  onTapEscaneacdigo() {}

  /// Navigates to the popUpInsertQrCodeScreen when the action is triggered.
  onTapTxtIntroduceeln() {
    Get.toNamed(
      AppRoutes.popUpInsertQrCodeScreen,
    );
  }
}
