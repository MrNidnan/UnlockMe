import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/pop_up_insert_qr_code_controller.dart'; // ignore_for_file: must_be_immutable

class PopUpInsertQrCodeScreen extends GetWidget<PopUpInsertQrCodeController> {
  const PopUpInsertQrCodeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: Container(
          width: 429.h,
          padding: EdgeInsets.symmetric(
            horizontal: 65.h,
            vertical: 46.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "msg_n_mero_debajo_del".tr,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 41.v),
              Divider(
                color: appTheme.blueGray100,
                endIndent: 54.h,
              ),
              SizedBox(height: 42.v),
              Padding(
                padding: EdgeInsets.only(right: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      height: 43.v,
                      text: "lbl_ok".tr,
                      margin: EdgeInsets.only(left: 27.h),
                      buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }
}
