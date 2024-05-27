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
    SizeUtils.setScreenSize(
        MediaQuery.of(context), MediaQuery.of(context).orientation);

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
              Positioned(
                bottom: MediaQuery.of(context).size.height *
                    0.10, // Adjust based on your layout needs
                child: CustomFloatingButton(
                  heroTag: 'qr-scan-1',
                  height: 58,
                  width: 58,
                  onTap: () {
                    navigateToQrScan();
                  },
                  child: CustomImageView(
                    imagePath: ImageConstant.imgQrIcon,
                    height: 29.0,
                    width: 29.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _buildBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: SizeUtils.height,
      width: SizeUtils.width,
      child: FlutterMap(
        options: MapOptions(
          initialCenter:
              controller.currentPosition.value ?? controller.defaultPostion,
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
          MarkerLayer(markers: controller.markers),
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
            height: 35,
            width: 35,
            onTap: () {
              navigateToSettings();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgSettings,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.perfilUsuarioScreen);
  }

  void navigateToQrScan() {
    Get.toNamed(AppRoutes.escanearQrScreen);
  }
}
