import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/app_export.dart';
import '../../core/utils/file_upload_helper.dart';
import '../../core/utils/permission_manager.dart';
import 'controller/perfil_usuario_controller.dart'; // ignore_for_file: must_be_immutable

class PerfilUsuarioScreen extends GetWidget<PerfilUsuarioController> {
  const PerfilUsuarioScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onSecondaryContainer,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 28.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 80.v),
                    padding: EdgeInsets.symmetric(horizontal: 21.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage3Traced,
                          height: 21.v,
                          width: 103.h,
                        ),
                        SizedBox(height: 41.v),
                        Padding(
                          padding: EdgeInsets.only(left: 7.h),
                          child: Text(
                            "lbl_configuraci_n".tr,
                            style: CustomTextStyles.titleMediumBold_1,
                          ),
                        ),
                        SizedBox(height: 80.v),
                        Align(
                          alignment: Alignment.center,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            margin: EdgeInsets.all(0),
                            color: appTheme.gray100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyle.circleBorder56,
                            ),
                            child: Container(
                              height: 112.adaptSize,
                              width: 112.adaptSize,
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.h,
                                vertical: 3.v,
                              ),
                              decoration: AppDecoration.fillGray.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder56,
                              ),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIstockphoto120,
                                    height: 99.adaptSize,
                                    width: 99.adaptSize,
                                    radius: BorderRadius.circular(
                                      49.h,
                                    ),
                                    alignment: Alignment.center,
                                    onTap: () {
                                      requestCameraGalleryPermission();
                                    },
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgSettings,
                                    height: 19.adaptSize,
                                    width: 19.adaptSize,
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 1.h),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "lbl_juana_sanz".tr,
                            style: CustomTextStyles.titleMediumPrimaryBold,
                          ),
                        ),
                        SizedBox(height: 7.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "msg_juanasanz_gmail_com".tr,
                            style: CustomTextStyles.bodySmallBluegray300,
                          ),
                        ),
                        SizedBox(height: 33.v),
                        GestureDetector(
                          onTap: () {
                            onTapProfile();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 24.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgLock,
                                  height: 16.v,
                                  width: 12.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text(
                                    "lbl_perfil".tr,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 28.v),
                        GestureDetector(
                          onTap: () {
                            onTapHistory();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 18.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgGroup1450,
                                  height: 18.adaptSize,
                                  width: 18.adaptSize,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigateToHistory();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 7.h,
                                      bottom: 2.v,
                                    ),
                                    child: Text(
                                      "lbl_historial".tr,
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 33.v),
                        GestureDetector(
                          onTap: () {
                            onTapLinkvehicles();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgArrowUp,
                                  height: 17.adaptSize,
                                  width: 17.adaptSize,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 9.h,
                                    bottom: 2.v,
                                  ),
                                  child: Text(
                                    "msg_activaci_n_veh_culos".tr,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.v),
                        Padding(
                          padding: EdgeInsets.only(left: 18.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgCardPayment,
                                height: 20.adaptSize,
                                width: 20.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 6.h,
                                  top: 4.v,
                                ),
                                child: Text(
                                  "lbl_formas_de_pago".tr,
                                  style: theme.textTheme.titleSmall,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 34.v),
                        GestureDetector(
                          onTap: () {
                            onTapHowtouse();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 25.h),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgQuestion,
                                  height: 18.adaptSize,
                                  width: 18.adaptSize,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Text(
                                    "lbl_ayuda".tr,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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

  /// Navigates to the editarPerfilScreen when the action is triggered.
  onTapProfile() {
    Get.toNamed(
      AppRoutes.editarPerfilScreen,
    );
  }

  onTapHistory() {}
  navigateToHistory() {}

  /// Navigates to the escanearQrScreen when the action is triggered.
  onTapLinkvehicles() {
    Get.toNamed(
      AppRoutes.escanearQrScreen,
    );
  }

  onTapHowtouse() {}
}
