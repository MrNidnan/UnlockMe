import 'package:flutter/material.dart';

// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 375;
const num FIGMA_DESIGN_HEIGHT = 667;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get _height => SizeUtils.height;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get v =>
      (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);
  double get adaptSize {
    var height = v;
    var width = h;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  double get fSize => adaptSize;
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(
            MediaQuery.of(context), MediaQuery.of(context).orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;
  static late double horizontalBlockSize;
  static late double verticalBlockSize;

  static void setScreenSize(
    MediaQueryData mediaQueryData,
    Orientation currentOrientation,
  ) {
    boxConstraints = BoxConstraints(
      maxHeight: mediaQueryData.size.height,
      maxWidth: mediaQueryData.size.width,
    );
    orientation = currentOrientation;
    horizontalBlockSize = mediaQueryData.size.width / 100;
    verticalBlockSize = mediaQueryData.size.height / 100;
    if (orientation == Orientation.portrait) {
      width =
          boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width =
          boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }

  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    horizontalBlockSize = width / 100;
    verticalBlockSize = height / 100;

    boxConstraints = BoxConstraints(
      maxHeight: height,
      maxWidth: width,
    );

    deviceType = DeviceType.mobile;
  }

  static double paddingSmall() => height * 0.01;
  static double paddingMedium() => height * 0.02;
  static double paddingLarge() => height * 0.03;

  static double marginSmall() => height * 0.01;
  static double marginMedium() => height * 0.02;
  static double marginLarge() => height * 0.03;

  static double textBoxHeight() => height * 0.06;
  static double buttonHeight() => height * 0.07;
}
