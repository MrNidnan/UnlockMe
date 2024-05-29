import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomFloatingButton extends StatelessWidget {
  static BoxDecoration get defaultDecoration => BoxDecoration(
        color: appTheme.blueGray100,
        borderRadius: BorderRadius.circular(29.h),
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green900,
        borderRadius: BorderRadius.circular(29.h),
      );

  CustomFloatingButton(
      {Key? key,
      this.heroTag,
      this.alignment,
      this.backgroundColor,
      this.onTap,
      this.width,
      this.height,
      this.decoration,
      this.child})
      : super(
          key: key,
        );
  final String? heroTag;
  final Alignment? alignment;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center, child: fabWidget)
        : fabWidget;
  }

  Widget get fabWidget => FloatingActionButton(
        heroTag: heroTag,
        backgroundColor: backgroundColor,
        onPressed: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width ?? 0,
          height: height ?? 0,
          decoration: decoration ?? CustomFloatingButton.defaultDecoration,
          child: child,
        ),
      );
}
