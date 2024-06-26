import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/qr_scan_controller.dart';

class QrScanScreen extends GetWidget<QrScanController> {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      alignment: Alignment.center,
                      child: DottedBorder(
                        color: theme.colorScheme.primaryContainer,
                        padding: EdgeInsets.all(SizeUtils.width * 0.01),
                        strokeWidth: SizeUtils.width * 0.005,
                        radius: const Radius.circular(50),
                        borderType: BorderType.Rect,
                        dashPattern: const [250, 50],
                        child: Container(
                          height: SizeUtils.width * 0.8,
                          width: SizeUtils.width * 0.8,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.zero,
                          ),
                          child: MobileScanner(
                            key: GlobalKey(debugLabel: 'QR'),
                            onDetect: (barcode) {
                              if (barcode.raw != null) {
                                controller.onQrDetect(barcode.barcodes.first);
                              }
                            },
                          ),
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
                        child: CustomImageView(
                          imagePath: ImageConstant.imgChevronLeft,
                          height: SizeUtils.height * 0.05,
                          width: SizeUtils.width * 0.15,
                          onTap: () {
                            onTapImgArrowleftone();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                width: SizeUtils.width * 0.5,
                text: "msg_escanea_c_digo_qr".tr,
                buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
                onPressed: () {
                  controller.onQrScan();
                },
              ),
              SizedBox(height: SizeUtils.height * 0.025),
              SizedBox(
                width: SizeUtils.width * 0.8,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "lbl3".tr,
                        style: CustomTextStyles.titleLargeSemiBold,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomElevatedButton(
                text: "msg_introduce_el_n_mero".tr,
                width: SizeUtils.width * 0.5,
                buttonStyle: CustomButtonStyles.outlineDark,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
                onPressed: () {
                  controller.navigateToManualQr();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapImgArrowleftone() {
    Get.back();
  }
}
