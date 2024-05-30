import 'package:UnlockMe/widgets/custom_nav_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import '../../core/app_export.dart';
import 'controller/contadorviaje_controller.dart';

class ContadorviajeScreen extends GetWidget<ContadorviajeController> {
  const ContadorviajeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ;

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeUtils.height * 0.05),
                CustomNavLeftWidget(
                  screenHeight: SizeUtils.height,
                  screenWidth: SizeUtils.width,
                  onTap: () {
                    controller.goBackToMap();
                  },
                ),
                SizedBox(
                  height: 239.0,
                  width: 278.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
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
                              Obx(() => Text(
                                    "${controller.getTimerTime()}".tr,
                                    style: CustomTextStyles.displaySmallPrimary,
                                  )),
                              SizedBox(height: 4.0),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "lbl_horas".tr,
                                      style: CustomTextStyles.bodyMediumPrimary,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 14.0),
                                      child: Text(
                                        "lbl_minutos".tr,
                                        style:
                                            CustomTextStyles.bodyMediumPrimary,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
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
                      child: Obx(() {
                        final started = controller.routeCreatedAt.value;
                        return Text(
                          "${started}".tr,
                          style: CustomTextStyles.bodyLargePrimary,
                        );
                      }),
                    )
                  ],
                ),
                SizedBox(height: 27.0),
                CustomImageView(
                  imagePath: ImageConstant.imgTraveller,
                  height: 133.0,
                  width: 134.0,
                ),
                SizedBox(height: 30.0),
                _buildSlider(context),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return Column(
      children: [
        Text(
          "msg_desliza_para_finalizar".tr,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 5.0), // Spacer between text and slider
        Container(
          width: MediaQuery.of(context).size.width *
              0.8, // Adjust the width as needed
          child: FlutterSlider(
            values: [0],
            max: 100,
            min: 0,
            handler: FlutterSliderHandler(
              decoration: BoxDecoration(
                color: appTheme.yellow300,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.5),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                height: 20.0, // Adjust handler height
                width: 20.0, // Adjust handler width
                decoration: BoxDecoration(
                  color: appTheme.yellow300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              if (lowerValue == 100 && !controller.routeFinished) {
                controller.endTravelRoute();
              }
            },
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 16.0, // Increased height
              inactiveTrackBarHeight: 16.0, // Increased height
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: appTheme.yellow300,
              ),
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
