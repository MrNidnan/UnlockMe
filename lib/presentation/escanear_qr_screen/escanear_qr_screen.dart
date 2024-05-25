import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/escanear_qr_controller.dart';

class EscanearQrScreen extends GetWidget<EscanearQrController> {
  const EscanearQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeUtils.setScreenSize(
        MediaQuery.of(context), MediaQuery.of(context).orientation);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(
                height: SizeUtils.height * 0.6,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.width * 0.05,
                          vertical: SizeUtils.height * 0.04,
                        ),
                        decoration: AppDecoration.fillGray300.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBL50,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: SizeUtils.height * 0.01),
                            DottedBorder(
                              color: theme.colorScheme.primaryContainer,
                              padding: EdgeInsets.all(SizeUtils.width * 0.01),
                              strokeWidth: SizeUtils.width * 0.005,
                              radius: Radius.circular(50),
                              borderType: BorderType.RRect,
                              dashPattern: [210, 270],
                              child: Container(
                                height: SizeUtils.height * 0.45,
                                width: SizeUtils.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: QRView(
                                  key: GlobalKey(debugLabel: 'QR'),
                                  onQRViewCreated: _onQRViewCreated,
                                  overlay: QrScannerOverlayShape(
                                    borderColor: theme.colorScheme.primary,
                                    borderRadius: 10,
                                    borderLength: 30,
                                    borderWidth: 10,
                                    cutOutSize: SizeUtils.width * 0.8,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.width * 0.035,
                          vertical: SizeUtils.height * 0.02,
                        ),
                        decoration:
                            AppDecoration.fillOnSecondaryContainer.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBL50,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowLeftTeal900,
                          height: SizeUtils.height * 0.03,
                          width: SizeUtils.height * 0.03,
                          onTap: () {
                            onTapImgArrowleftone();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeUtils.height * 0.04),
              CustomElevatedButton(
                width: SizeUtils.width * 0.5,
                text: "msg_escanea_c_digo_qr".tr,
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
                onPressed: () {
                  onTapEscaneacdigo();
                },
              ),
              SizedBox(height: SizeUtils.height * 0.01),
              SizedBox(
                width: SizeUtils.width * 0.8,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl3".tr,
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                      TextSpan(
                        text: "\n".tr,
                        style: CustomTextStyles.headlineMediumArchivo,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: SizeUtils.height * 0.01),
              GestureDetector(
                onTap: () {
                  onTapTxtIntroduceeln();
                },
                child: Text(
                  "msg_introduce_el_n_mero".tr,
                  style: CustomTextStyles.titleMediumBold,
                ),
              ),
              SizedBox(height: SizeUtils.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    //controller.scannedDataStream.listen((scanData) {
    // Handle the scanned data
    //  controller.pauseCamera();
    //});
  }

  void onTapImgArrowleftone() {
    Get.back();
  }

  void onTapEscaneacdigo() {
    // Handle QR scan button tap
  }

  void onTapTxtIntroduceeln() {
    Get.toNamed(AppRoutes.popUpInsertQrCodeScreen);
  }
}
