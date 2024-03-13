import 'package:flutter/material.dart';

import '../../../models/index.dart';

enum CartStyle {
  normal,
  style01;

  bool get isNormal => this == CartStyle.normal;
  bool get isStyle01 => this == CartStyle.style01;
}

class CartItemStateUI {
  final bool? enableTopDivider;
  final bool enableBottomDivider;
  final Product product;
  final List<AddonsOption>? addonsOptions;
  final ProductVariation? variation;
  final Map? options;
  final int? quantity;

  final bool Function(int value)? onChangeQuantity;
  final VoidCallback? onRemove;
  final bool showStoreName;
  final bool enabledTextBoxQuantity;

  final String? imageFeature;
  final String? price;

  final bool isOnBackorder;
  final bool inStock;
  final dynamic limitQuantity;
  final void Function(BuildContext context, {required Product product})
  onTapProduct;

  CartItemStateUI({
    this.enableTopDivider,
    required this.enableBottomDivider,
    required this.product,
    this.addonsOptions,
    this.variation,
    this.options,
    this.quantity,
    this.enabledTextBoxQuantity = true,
    this.onChangeQuantity,
    this.onRemove,
    required this.showStoreName,
    this.imageFeature,
    this.price,
    required this.isOnBackorder,
    required this.inStock,
    this.limitQuantity,
    required this.onTapProduct,
  });
}

extension CartStyleFromStringExt on String? {
  CartStyle toCartStyle() {
    if (this?.isEmpty ?? true) {
      return CartStyle.normal;
    }

    switch (this) {
      case 'style01':
        return CartStyle.style01;
      case 'normal':
      default:
        return CartStyle.normal;
    }
  }
}