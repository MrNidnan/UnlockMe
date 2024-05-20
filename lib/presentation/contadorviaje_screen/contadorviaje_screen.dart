import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/contadorviaje_controller.dart'; // ignore_for_file: must_be_immutable

class ContadorviajeScreen extends GetWidget<ContadorviajeController> {
  const ContadorviajeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 38.h,
            vertical: 6.v,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 7.v,
                        bottom: 4.v,
                      ),
                      child: Text(
                        "lbl_c_mo_llegar".tr,
                        style: CustomTextStyles.bodySmall10.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowLeftYellow300,
                      height: 22.v,
                      width: 23.h,
                      margin: EdgeInsets.only(left: 8.h),
                      onTap: () {
                        onTapImgArrowleftone();
                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.v),
                      child: Text(
                        "lbl_01_abr_2024".tr,
                        style: CustomTextStyles.labelLargePrimary,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 37.v),
              SizedBox(
                height: 239.v,
                width: 238.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 239.v,
                        width: 238.h,
                        child: CircularProgressIndicator(
                          value: 0.5,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 28.h,
                          right: 22.h,
                          bottom: 83.v,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "lbl_02_30_00".tr,
                              style: CustomTextStyles.displaySmallPrimary,
                            ),
                            SizedBox(height: 4.v),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "lbl_horas".tr,
                                    style: CustomTextStyles.bodyMediumPrimary,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 24.h),
                                    child: Text(
                                      "lbl_minutos".tr,
                                      style: CustomTextStyles.bodyMediumPrimary,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.h),
                                    child: Text(
                                      "lbl_segundos".tr,
                                      style: CustomTextStyles.bodyMediumPrimary,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 27.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "lbl_hora_de_inicio".tr,
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7.h),
                    child: Text(
                      "lbl_11_00".tr,
                      style: CustomTextStyles.bodyLargePrimary,
                    ),
                  )
                ],
              ),
              SizedBox(height: 27.v),
              CustomImageView(
                imagePath: ImageConstant.imgC268d1f55b3a,
                height: 133.v,
                width: 134.h,
              ),
              SizedBox(height: 20.v),
              CustomElevatedButton(
                text: "msg_desliza_para_finalizar".tr,
                margin: EdgeInsets.only(
                  left: 49.h,
                  right: 27.h,
                ),
                leftIcon: Container(
                  padding: EdgeInsets.fromLTRB(12.h, 12.v, 9.h, 10.v),
                  margin: EdgeInsets.only(right: 7.h),
                  decoration: BoxDecoration(
                    color: appTheme.green900,
                    borderRadius: BorderRadius.circular(
                      16.h,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary,
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: Offset(
                          0,
                          2,
                        ),
                      )
                    ],
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgForward,
                    height: 10.v,
                    width: 11.h,
                  ),
                ),
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                buttonTextStyle: CustomTextStyles.titleMediumGreen900,
                onPressed: () {
                  onTapDeslizapara();
                },
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 5.v)
            ],
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

  /// Navigates to the previous screen.
  onTapChevronleftone() {
    Get.back();
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }

  onTapDeslizapara() {}
}
