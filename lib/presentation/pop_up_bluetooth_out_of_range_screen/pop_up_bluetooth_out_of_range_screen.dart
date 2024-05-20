import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/pop_up_bluetooth_out_of_range_controller.dart'; // ignore_for_file: must_be_immutable

class PopUpBluetoothOutOfRangeScreen
    extends GetWidget<PopUpBluetoothOutOfRangeController> {
  const PopUpBluetoothOutOfRangeScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: Container(
          width: 261.h,
          padding: EdgeInsets.symmetric(
            horizontal: 26.h,
            vertical: 45.v,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 24.adaptSize,
                width: 24.adaptSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgWarning1,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgWarning1,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
              SizedBox(height: 13.v),
              Container(
                width: 201.h,
                margin: EdgeInsets.only(right: 6.h),
                child: Text(
                  "msg_debes_estar_dentro".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    height: 1.66,
                  ),
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
