import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/pantalla_reserva_controller.dart';

// ignore_for_file: must_be_immutable
class PantallaReserva extends GetWidget<PantallaReservaController> {
  const PantallaReserva({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the screen size using SizeUtils
    SizeUtils.setScreenSize(
        MediaQuery.of(context), MediaQuery.of(context).orientation);
    final screenHeight = SizeUtils.height;
    final screenWidth = SizeUtils.width;
    //var modelReserva = controller.pantallaReservaModelObj.value; //observable variable

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgChevronLeft,
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.15,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: screenWidth * 0.01),
                  onTap: () {
                    onTapImgArrowleftone();
                  },
                ),

                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.2),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;
                    return Text(
                      "Bike ID: ${modelReserva.bike.id}",
                      style: theme.textTheme.titleMedium,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.2),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;

                    return Text(
                      "Location: (${modelReserva.bike.latitude}, ${modelReserva.bike.longitude})",
                      style: theme.textTheme.titleMedium,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.2),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;

                    return Text(
                      "Battery Life: ${modelReserva.bike.batteryLife}%",
                      style: CustomTextStyles.titleMediuemOrange800,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.07),
                Obx(() {
                  final modelReserva = controller.pantallaReservaModelObj.value;

                  if (modelReserva.isReserved) {
                    return Column(
                      children: [
                        Obx(() {
                          return Text(
                            "Remaining Time: ${controller.remainingTime.value} seconds",
                            style: theme.textTheme.headlineSmall,
                          );
                        }),
                        SizedBox(height: screenHeight * 0.03),
                        CustomElevatedButton(
                          width: screenWidth * 0.4,
                          text: "Cancel Reservation".tr,
                          onPressed: () {
                            controller.cancelReservation();
                          },
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.2),
                      child: CustomElevatedButton(
                        width: screenWidth * 0.4,
                        text: "Reserve".tr,
                        onPressed: () {
                          onTapReserve();
                          //controller.createReservation();
                        },
                      ),
                    );
                  }
                }),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapImgArrowleftone() {
    Get.back();
  }

  void onTapReserve() {
    Get.toNamed(AppRoutes.contadorreservaScreen);
  }
}
