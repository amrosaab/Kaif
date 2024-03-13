import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../models/entities/index.dart';
import '../../../models/product_model.dart';
import '../../../models/product_variant_model.dart';
import '../../../services/service_config.dart';
import '../../../services/services.dart';

class BuyButtonWidget extends StatelessWidget {
  const BuyButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ProductVariantModel>(context);
    var productVariation = model.productVariation;
    var product = model.product ?? Product();
    var mapAttribute = model.mapAttribute;
    var quantity = model.quantity;
    var variations = context.select((ProductModel _) => _.variations);
    var isInAppPurchaseChecking = model.isInAppPurchaseChecking;

    return Column(
      children: Services().widget.getBuyButtonWidget(
          context,
          productVariation,
          product,
          mapAttribute,
          _getMaxQuantity(product, productVariation),
          quantity, ([bool buyNow = false, bool inStock = false]) {
        _addToCart(context, buyNow, inStock);
      }, (val) {
        model.updateValues(quantity: val);
      }, variations, isInAppPurchaseChecking),
    );
  }

  /// check limit select quality by maximum available stock
  int _getMaxQuantity(Product product, ProductVariation? productVariation) {
    var limitSelectQuantity = kCartDetail['maxAllowQuantity'] ?? 100;

    /// Skip check stock quantity for backorder products.
    if (product.backordersAllowed) {
      return limitSelectQuantity;
    }

    if (productVariation != null) {
      if (productVariation.stockQuantity != null) {
        limitSelectQuantity = math.min<int>(
            productVariation.stockQuantity!, kCartDetail['maxAllowQuantity']);
      }
    } else if (product.stockQuantity != null) {
      limitSelectQuantity = math.min<int>(
          product.stockQuantity!, kCartDetail['maxAllowQuantity']);
    }
    return limitSelectQuantity;
  }

  /// Add to Cart & Buy Now function
  void _addToCart(BuildContext context,
      [bool buyNow = false, bool inStock = false]) {
    var model = Provider.of<ProductVariantModel>(context, listen: false);
    var productVariation = model.productVariation;
    var product = model.product ?? Product();
    var mapAttribute = model.mapAttribute;
    var quantity = model.quantity;

    if (buyNow &&
        Services().widget.enableInAppPurchase &&
        !ServerConfig().isBuilder) {
      Services().doIAPPayment(
          context, product, productVariation, quantity, mapAttribute ?? {},
          (bool isLoading) {
        model.updateValues(isInAppPurchaseChecking: isLoading);
      }, () {
        Services().widget.addToCart(context, product, quantity,
            productVariation, mapAttribute ?? {}, buyNow, inStock);
      });
    } else {
      Services().widget.addToCart(context, product, quantity, productVariation,
          mapAttribute ?? {}, buyNow, inStock);
    }
  }
}
