import 'package:flutter/material.dart';

class QuantitySelectionStateUI {
  final int currentQuantity;
  final TextEditingController textController;
  final int limitSelectQuantity;
  final void Function() onQuantityChanged;
  final void Function(int value) changeQuantity;
  final double width;
  final double height;
  final bool enabled;
  final bool enabledTextBox;
  final bool expanded;
  final FocusNode? focusNode;

  QuantitySelectionStateUI({
    required this.currentQuantity,
    required this.textController,
    required this.limitSelectQuantity,
    required this.onQuantityChanged,
    required this.changeQuantity,
    required this.width,
    required this.enabledTextBox,
    required this.height,
    required this.enabled,
    required this.expanded,
    this.focusNode,
  });
}