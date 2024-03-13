import 'package:flutter/material.dart';

import '../../index.dart';
import '../floating_action_button/circle_type/circle_notched.dart';
import '../floating_action_button/diamond_type/index.dart';
import '../floating_action_button/rectangle_type/rectangle_notched.dart';

mixin TabbarFloatingShape {
  ShapeBorder getShapeBorder(TabBarFloatingConfig config) {
    switch (config.floatingType) {
      case FloatingType.diamond:
        return const DiamondBorder();
      case FloatingType.rectangle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.radius ?? 50.0),
        );
      case FloatingType.circle:
      default:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        );
    }
  }

  NotchedShape renderNotchedShape(TabBarFloatingConfig config) {
    switch (config.floatingType) {
      case FloatingType.diamond:
        return DiamondNotched(
          margin: config.notchMargin,
          isCoverMode: config.isCoverMode,
        );
      case FloatingType.rectangle:
        return RectangleNotched(
          isCoverMode: config.isCoverMode,
          radius: config.radius,
        );
      case FloatingType.circle:
      default:
        return CircleNotched(
          isCoverMode: config.isCoverMode,
        );
    }
  }
}
