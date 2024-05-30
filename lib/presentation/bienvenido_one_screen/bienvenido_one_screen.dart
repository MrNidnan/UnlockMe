import 'package:UnlockMe/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/bienvenido_one_controller.dart'; // ignore_for_file: must_be_immutable

class BienvenidoOneScreen extends GetWidget<BienvenidoOneController> {
  const BienvenidoOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context); // Initialize SizeUtils here

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondaryContainer,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal:
                  SizeUtils.horizontalBlockSize * 8, // Responsive padding
              vertical: SizeUtils.verticalBlockSize *
                  5, // Adjusted padding to fit better
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage3Traced,
                  height: SizeUtils.verticalBlockSize * 20, // Adjusted height
                  width: SizeUtils.horizontalBlockSize * 60, // Responsive width
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                      right: SizeUtils.horizontalBlockSize *
                          2.5), // Responsive margin
                ),
                SizedBox(
                    height: SizeUtils.verticalBlockSize *
                        5), // Spacer to replace Spacer()
                CustomImageView(
                  imagePath: ImageConstant.imgDallE20231106,
                  height: SizeUtils.verticalBlockSize * 30, // Adjusted height
                  width: SizeUtils.horizontalBlockSize * 70, // Responsive width
                ),
                SizedBox(
                    height:
                        SizeUtils.verticalBlockSize * 10), // Responsive spacing
                Center(
                  child: CustomElevatedButton(
                    width: SizeUtils.horizontalBlockSize *
                        40, // Responsive button width
                    text: "lbl_empezar".tr,
                    buttonStyle: CustomButtonStyles.fillYellowTL20,
                    buttonTextStyle: CustomTextStyles.titleMediumGray800,
                    onPressed: () {
                      onTapEmpezar();
                    },
                  ),
                ),
                SizedBox(
                    height:
                        SizeUtils.verticalBlockSize * 1) // Responsive spacing
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the bienvenidoScreen when the action is triggered.
  onTapEmpezar() {
    Get.toNamed(
      AppRoutes.bienvenidoScreen,
    );
  }
}
