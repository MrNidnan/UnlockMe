import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/pantalla_reserva_controller.dart';

class PantallaReserva extends GetWidget<PantallaReservaController> {
  const PantallaReserva({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bike = controller.pantallaReservaModelObj;

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
                  "Bike ID: ${bike.bikeId}",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 8.v),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Location: (${bike.latitude}, ${bike.longitude})",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 21.v),
              Padding(
                padding: EdgeInsets.only(left: 74.h),
                child: Text(
                  "Battery Life: ${bike.batteryLife}%",
                  style: CustomTextStyles.bodySmallBluegray100,
                ),
              ),
              SizedBox(height: 55.v),
              Obx(() {
                if (bike.isReserved) {
                  return Column(
                    children: [
                      Text(
                        "Remaining Time: ${controller.remainingTime.value} seconds",
                        style: theme.textTheme.headlineSmall,
                      ),
                      SizedBox(height: 20.v),
                      CustomElevatedButton(
                        width: 150.h,
                        text: "Cancel Reservation".tr,
                        onPressed: () {
                          controller.cancelReservation();
                        },
                      ),
                    ],
                  );
                } else {
                  return CustomElevatedButton(
                    width: 150.h,
                    text: "Reserve".tr,
                    onPressed: () {
                      controller.createReservation();
                    },
                  );
                }
              }),
              SizedBox(height: 10.v),
            ],
          ),
        ),
      ),
    );
  }

  onTapImgArrowleftone() {
    Get.back();
  }
}
