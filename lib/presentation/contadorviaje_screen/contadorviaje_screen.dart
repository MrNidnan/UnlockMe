import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/contadorviaje_controller.dart';

class ContadorviajeScreen extends GetWidget<ContadorviajeController> {
  const ContadorviajeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 7.0,
                          bottom: 4.0,
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
                        height: 22.0,
                        width: 23.0,
                        margin: EdgeInsets.only(left: 8.0),
                        onTap: () {
                          onTapImgArrowleftone();
                        },
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 7.0),
                        child: Text(
                          "lbl_01_abr_2024".tr,
                          style: CustomTextStyles.labelLargePrimary,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 37.0),
                SizedBox(
                  height: 239.0,
                  width: 238.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 239.0,
                          width: 238.0,
                          child: CircularProgressIndicator(
                            value: 0.5,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 28.0,
                            right: 22.0,
                            bottom: 83.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "lbl_02_30_00".tr,
                                style: CustomTextStyles.displaySmallPrimary,
                              ),
                              SizedBox(height: 4.0),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "lbl_horas".tr,
                                      style: CustomTextStyles.bodyMediumPrimary,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 24.0),
                                      child: Text(
                                        "lbl_minutos".tr,
                                        style:
                                            CustomTextStyles.bodyMediumPrimary,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "lbl_segundos".tr,
                                        style:
                                            CustomTextStyles.bodyMediumPrimary,
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
                SizedBox(height: 27.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "lbl_hora_de_inicio".tr,
                      style: CustomTextStyles.titleMediumPrimary,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.0),
                      child: Text(
                        "lbl_11_00".tr,
                        style: CustomTextStyles.bodyLargePrimary,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 27.0),
                CustomImageView(
                  imagePath: ImageConstant.imgTraveller,
                  height: 133.0,
                  width: 134.0,
                ),
                SizedBox(height: 20.0),
                FlutterSlider(
                  values: [0],
                  max: 100,
                  min: 0,
                  handler: FlutterSliderHandler(
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    if (lowerValue == 100) {
                      controller.endTravel();
                    }
                  },
                  tooltip: FlutterSliderTooltip(
                    disabled: true,
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBarHeight: 8.0,
                    inactiveTrackBarHeight: 8.0,
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: theme.colorScheme.primary,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 5.0)
              ],
            ),
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
          left: 14.0,
          right: 337.0,
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
}
