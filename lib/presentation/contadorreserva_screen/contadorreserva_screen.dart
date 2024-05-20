import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/contadorreserva_controller.dart'; // ignore_for_file: must_be_immutable

class ContadorreservaScreen extends GetWidget<ContadorreservaController> {
  const ContadorreservaScreen({Key? key})
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
            vertical: 27.v,
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
                        style: CustomTextStyles.labelLargePrimaryContainer13,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 39.v),
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
                              "lbl_00_15_00".tr,
                              style: theme.textTheme.displaySmall,
                            ),
                            SizedBox(height: 4.v),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "lbl_horas".tr,
                                    style: CustomTextStyles.bodyMedium13,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 24.h),
                                    child: Text(
                                      "lbl_minutos".tr,
                                      style: CustomTextStyles.bodyMedium13,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.h),
                                    child: Text(
                                      "lbl_segundos".tr,
                                      style: CustomTextStyles.bodyMedium13,
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
              SizedBox(height: 35.v),
              Text(
                "msg_vehiculo_reservado".tr,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 66.v),
              CustomElevatedButton(
                text: "lbl_ok".tr,
                margin: EdgeInsets.symmetric(horizontal: 38.h),
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgForward,
                    height: 10.v,
                    width: 11.h,
                  ),
                ),
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                onPressed: () {
                  onTapOk();
                },
              ),
              SizedBox(height: 31.v),
              CustomElevatedButton(
                text: "lbl_cancelar".tr,
                margin: EdgeInsets.symmetric(horizontal: 38.h),
                buttonStyle: CustomButtonStyles.outlinePrimary,
                buttonTextStyle: CustomTextStyles.titleMediumTeal900,
                onPressed: () {
                  onTapCancelar();
                },
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

  onTapOk() {}
  onTapCancelar() {}
}
