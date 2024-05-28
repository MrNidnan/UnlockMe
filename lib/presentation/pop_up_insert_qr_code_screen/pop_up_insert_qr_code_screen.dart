import 'package:UnlockMe/widgets/custom_text_form_field.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      controller.goBack();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "msg_n_mero_debajo_del".tr,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 41.v),
              Align(
                alignment: Alignment.center,
                child: CustomTextFormField(
                  controller: controller.inputTextController,
                  textInputType: TextInputType.text,
                  borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
                  width: SizeUtils.width * 0.75,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CustomElevatedButton(
                  height: 43.v,
                  text: "lbl_ok".tr,
                  margin: EdgeInsets.all(40.h),
                  buttonStyle: CustomButtonStyles.outlinePrimaryTL20,
                  onPressed: () {
                    controller.readQrString();
                  },
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
