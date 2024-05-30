import 'package:UnlockMe/theme/custom_button_style.dart';
import 'package:UnlockMe/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller/mapa_controller.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_floating_button.dart';
import '../../widgets/custom_icon_button.dart';

class MapaScreen extends GetWidget<MapaController> {
  MapaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: SizeUtils.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //_buildMap(),
              Obx(() => _buildMap()),
              Obx(() {
                final isRouteRunning = controller.isTravelTimerRunning.value;
                final isReserveRunning = controller.isReserveTimerRunning.value;
                return Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    children: [
                      isRouteRunning || isReserveRunning
                          ? CustomElevatedButton(
                              width: SizeUtils.width * 0.7,
                              text: controller.getTimerButtonLabel(),
                              buttonStyle:
                                  CustomButtonStyles.outlinedTimerButton,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary,
                              onPressed: () {
                                controller.navigateFromTimer();
                              },
                            )
                          : Container(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                );
              }),
              Positioned(
                  bottom: MediaQuery.of(context).size.height *
                      0.10, // Adjust based on your layout needs
                  child: Obx(() => _buildQrScanButton(
                      disabled: controller.isTravelTimerRunning.value))),
            ],
          ),
        ),
        floatingActionButton: _buildBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildMap() {
    final mapModel = controller.mapaModelObj.value;
    return SizedBox(
      height: SizeUtils.height,
      width: SizeUtils.width,
      child: FlutterMap(
        options: MapOptions(
          initialCenter:
              mapModel.currentPosition.value ?? controller.defaultPostion,
          initialZoom: 14.4746,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
          MarkerLayer(markers: mapModel.markers),
        ],
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: SizeUtils.height * 0.03),
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.width * 0.1,
        vertical: SizeUtils.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButton(
            height: 35.adaptSize,
            width: 35.adaptSize,
            padding: EdgeInsets.all(SizeUtils.width * 0.02),
            decoration: IconButtonStyleHelper.fillGray,
            onTap: () {
              controller.updateMap();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgLinkedin,
            ),
          ),
          Spacer(),
          CustomFloatingButton(
            heroTag: 'settings-1',
            backgroundColor: appTheme.green900,
            decoration: CustomFloatingButton.fillGreen,
            height: 60,
            width: 60,
            onTap: () {
              controller.navigateToSettings();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgSettings,
              height: 30,
              width: 30,
              color: appTheme.limeA200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrScanButton({disabled = false}) {
    var decoration = CustomFloatingButton.fillGreen;
    var color = appTheme.limeA200;
    var onTap = controller.navigateToQrScan;
    var backgroundColor = appTheme.green900;

    if (disabled) {
      decoration = CustomFloatingButton.defaultDecoration.copyWith(
        color: appTheme.gray300,
      );
      color = appTheme.gray600;
      backgroundColor = appTheme.gray300;
      onTap = () {
        // Do nothing
      };
    }
    return CustomFloatingButton(
      heroTag: 'qr-scan-1',
      backgroundColor: backgroundColor,
      decoration: decoration,
      height: 60,
      width: 60,
      onTap: onTap,
      child: CustomImageView(
        imagePath: ImageConstant.imgQrIcon,
        height: 30.0,
        width: 30.0,
        color: color,
      ),
    );
  }
}
