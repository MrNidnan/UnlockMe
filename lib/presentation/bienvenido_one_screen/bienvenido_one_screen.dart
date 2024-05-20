import 'package:flutter/material.dart';
import '../../core/app_export.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondaryContainer,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 86.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage3Traced,
                height: 50.v,
                width: 246.h,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 11.h),
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgDallE20231106,
                height: 199.v,
                width: 278.h,
              ),
              SizedBox(height: 82.v),
              CustomElevatedButton(
                width: 150.h,
                text: "lbl_empezar".tr,
                buttonStyle: CustomButtonStyles.fillYellowTL20,
                buttonTextStyle: CustomTextStyles.titleMediumGray800,
                onPressed: () {
                  onTapEmpezar();
                },
                alignment: Alignment.center,
              ),
              SizedBox(height: 4.v)
            ],
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
