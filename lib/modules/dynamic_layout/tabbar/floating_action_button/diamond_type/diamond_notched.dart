import 'package:flutter/material.dart';

class DiamondNotched extends NotchedShape {
  const DiamondNotched({
    required this.margin,
    required this.isCoverMode,
  });

  final double margin;
  final bool isCoverMode;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    if (isCoverMode) {
      return Path()
        ..moveTo(host.left, host.top)
        ..lineTo(guest.left - margin, host.top)
        ..lineTo(guest.center.dx, guest.top - margin)
        ..lineTo(guest.right + margin, host.top)
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(guest.left - margin, host.top)
      ..lineTo(guest.center.dx, guest.bottom + margin)
      ..lineTo(guest.right + margin, host.top)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
