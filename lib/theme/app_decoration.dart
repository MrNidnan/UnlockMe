import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray100,
      );
  static BoxDecoration get fillGray300 => BoxDecoration(
        color: appTheme.gray300,
      );
  static BoxDecoration get fillGray30066 => BoxDecoration(
        color: appTheme.gray30066,
      );
  static BoxDecoration get fillGray400 => BoxDecoration(
        color: appTheme.gray400,
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green900,
      );
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );
  static BoxDecoration get fillSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
      );
// Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
        boxShadow: [
          BoxShadow(
            color: appTheme.blueGray2003301,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder56 => BorderRadius.circular(
        56.h,
      );
// Custom borders
  static BorderRadius get customBorderBL50 => BorderRadius.vertical(
        bottom: Radius.circular(50.h),
      );
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder49 => BorderRadius.circular(
        49.h,
      );
}
