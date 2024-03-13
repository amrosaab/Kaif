import 'package:flutter/material.dart';

class RectangleNotched extends NotchedShape {
  const RectangleNotched({
    this.radius,
    required this.isCoverMode,
  });

  final double? radius;
  final bool isCoverMode;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    // BorderRadius for the tabbar
    const ShapeBorder hostShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    );

    // BorderRadius for the notchedShape
    final ShapeBorder guestShape = RoundedRectangleBorder(
      borderRadius: isCoverMode
          ? BorderRadius.only(
              topLeft: Radius.circular(radius ?? 50),
              topRight: Radius.circular(radius ?? 50),
            )
          : BorderRadius.only(
              bottomLeft: Radius.circular(radius ?? 50),
              bottomRight: Radius.circular(radius ?? 50),
            ),
    );

    final hostPath = hostShape.getOuterPath(host);

    if (guest != null) {
      final guestPath = guestShape.getOuterPath(guest);
      if (isCoverMode) {
        return Path.combine(PathOperation.union, hostPath, guestPath);
      }

      return Path.combine(PathOperation.difference, hostPath, guestPath);
    }
    return hostPath;
  }
}
