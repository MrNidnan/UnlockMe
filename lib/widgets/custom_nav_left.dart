import 'package:UnlockMe/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomNavLeftWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final VoidCallback onTap;

  CustomNavLeftWidget({
    required this.screenHeight,
    required this.screenWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgChevronLeft,
      height: screenHeight * 0.05,
      width: screenWidth * 0.15,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: screenWidth * 0.01),
      onTap: onTap,
    );
  }
}
