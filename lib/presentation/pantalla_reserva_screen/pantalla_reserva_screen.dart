import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/pantalla_reserva_controller.dart'; // ignore_for_file: must_be_immutable

class PantallaReservaScreen extends GetWidget<PantallaReservaController> {
  const PantallaReservaScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 36.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgCheckmark,
                height: 24.adaptSize,
                width: 24.adaptSize,
                alignment: Alignment.centerRight,
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 74.h),
                child: Text(
                  "lbl_a001".tr,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 8.v),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "msg_pl_jes_s_carrasco".tr,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 21.v),
              Padding(
                padding: EdgeInsets.only(left: 74.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgArrowLeftYellow300,
                      height: 22.v,
                      width: 23.h,
                      onTap: () {
                        onTapImgArrowleftone();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 4.v,
                        bottom: 3.v,
                      ),
                      child: Text(
                        "lbl_59_km".tr,
                        style: CustomTextStyles.labelLargeBluegray100_1,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.only(left: 105.h),
                child: Text(
                  "lbl_disponible".tr,
                  style: CustomTextStyles.bodySmallBluegray100,
                ),
              ),
              SizedBox(height: 55.v),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "msg_autonomia_aprox".tr,
                  style: CustomTextStyles.titleLargeOrange800,
                ),
              ),
              SizedBox(height: 47.v),
              CustomElevatedButton(
                width: 150.h,
                text: "lbl_reservar".tr,
                margin: EdgeInsets.only(left: 74.h),
              ),
              SizedBox(height: 10.v)
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
}
