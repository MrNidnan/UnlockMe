import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/app_export.dart';
import '../../core/utils/file_upload_helper.dart';
import '../../core/utils/permission_manager.dart';
import '../../widgets/custom_floating_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/mapa_controller.dart'; // ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class MapaScreen extends GetWidget<MapaController> {
  MapaScreen({Key? key})
      : super(
          key: key,
        );

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: SizeUtils.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgMapa1,
                height: 641.v,
                width: 375.h,
                alignment: Alignment.topCenter,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [SizedBox(height: 23.v), _buildMap(), Spacer()],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomAppBar(),
        floatingActionButton: CustomFloatingButton(
          height: 35,
          width: 35,
          onTap: () {
            navigateToSettings();
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgClose,
            height: 17.5.v,
            width: 17.5.h,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  /// Section Widget
  Widget _buildMap() {
    return SizedBox(
      height: 390.v,
      width: 345.h,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            37.43296265331129,
            -122.08832357078792,
          ),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomAppBar() {
    return SizedBox(
      child: SizedBox(
        height: 95.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 21.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 42.h,
                  vertical: 6.v,
                ),
                decoration: AppDecoration.fillGray30066.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderTL20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 28.h,
                        top: 4.v,
                        bottom: 5.v,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconButton(
                            height: 35.adaptSize,
                            width: 35.adaptSize,
                            padding: EdgeInsets.all(6.h),
                            decoration: IconButtonStyleHelper.fillGray,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLinkedin,
                            ),
                          ),
                          SizedBox(height: 3.v),
                          Text(
                            "lbl_mapa".tr,
                            style:
                                CustomTextStyles.labelLargePrimaryContainer_1,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.v),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomFloatingButton(
                            height: 35,
                            width: 35,
                            onTap: () {
                              navigateToSettings();
                            },
                            child: CustomImageView(
                              imagePath: ImageConstant.imgClose,
                              height: 17.5.v,
                              width: 17.5.h,
                            ),
                          ),
                          SizedBox(height: 7.v),
                          Text(
                            "lbl_configuraci_n".tr,
                            style: theme.textTheme.labelLarge,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomFloatingButton(
              height: 58,
              width: 58,
              backgroundColor: appTheme.blueGray100,
              alignment: Alignment.topCenter,
              onTap: () {
                requestCameraGalleryPermission();
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgPrinter,
                height: 29.0.v,
                width: 29.0.h,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates to the perfilUsuarioScreen when the action is triggered.
  navigateToSettings() {
    Get.toNamed(
      AppRoutes.perfilUsuarioScreen,
    );
  }

  /// Requests permission to access the camera and storage, and displays a model
  /// sheet for selecting images.
  ///
  /// Throws an error if permission is denied or an error occurs while selecting images.
  requestCameraGalleryPermission() async {
    await PermissionManager.askForPermission(Permission.camera);
    await PermissionManager.askForPermission(Permission.storage);
    List<String?>? imageList = [];
    await FileManager().showModelSheetForImage(getImages: (value) async {
      imageList = value;
    });
  }
}
