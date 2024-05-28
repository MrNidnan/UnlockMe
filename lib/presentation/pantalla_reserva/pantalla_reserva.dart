import 'package:UnlockMe/core/utils/bike_helper.dart';
import 'package:UnlockMe/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/pantalla_reserva_controller.dart';

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
                SizedBox(height: screenHeight * 0.05),
                CustomImageView(
                  imagePath: ImageConstant.imgChevronLeft,
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.15,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: screenWidth * 0.01),
                  onTap: () {
                    controller.goBackToMap();
                  },
                ),

                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                Align(
                  alignment: Alignment.center,
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;
                    return Text(
                      "Bike # ${modelReserva.bike.id}",
                      style: theme.textTheme.titleMedium,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: Obx(() {
                    final address = controller.address.value;
                    //final testVar = controller.testVar.value;
                    return Text(
                      "\n${address} ",
                      style: theme.textTheme.titleMedium,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;

                    return Text(
                      "Location: (${modelReserva.bike.latitude}, ${modelReserva.bike.longitude})",
                      style: theme.textTheme.titleSmall,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;

                    return Text(
                      "Battery Life: ${modelReserva.bike.batteryLife}%",
                      style: CustomTextStyles.titleMediuemOrange800,
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.15),
                  child: Obx(() {
                    final modelReserva =
                        controller.pantallaReservaModelObj.value;

                    return Text(
                      "Autonomy: ${BikeHelper.calculateAutonomy(modelReserva.bike.batteryLife)} Km aprox.",
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
                        Align(
                          alignment: Alignment.center,
                          child: CustomElevatedButton(
                            text: "lbl_cancelar".tr,
                            width: screenWidth * 0.4,
                            buttonStyle: CustomButtonStyles.outlineDark,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumPrimaryBold,
                            onPressed: () {
                              controller.onTapCancelReservation();
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: CustomElevatedButton(
                        width: screenWidth * 0.4,
                        text: "Reserve".tr,
                        onPressed: () {
                          //onTapReserve();
                          controller.createReservation();
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
}
