import 'package:flutter/material.dart';

import 'entities/product.dart';
import 'entities/product_addons.dart';
import 'entities/product_variation.dart';

class ProductVariantModel extends ChangeNotifier {
  Product? product;
  ProductVariation? productVariation;
  Map<String, Map<String, AddonsOption>> selectedOptions = {};
  List<AddonsOption> addonsOptions = [];
  int quantity = 1;
  bool isInAppPurchaseChecking = false;
  Map<String?, String?>? mapAttribute;

  void initWithProduct(Product p) {
    product = p;
  }

  void updateValues(
      {ProductVariation? productVariation,
      Map<String, Map<String, AddonsOption>>? selectedOptions,
      List<AddonsOption>? addonsOptions,
      int? quantity,
      bool? isInAppPurchaseChecking,
      Map<String?, String?>? mapAttribute}) {
    this.productVariation = productVariation ?? this.productVariation;

    this.selectedOptions = selectedOptions ?? this.selectedOptions;
    if (this.selectedOptions.values.isNotEmpty) {
      final options = <AddonsOption>[];
      for (var addOns in this.selectedOptions.values) {
        options.addAll(addOns.values);
      }
      product?.selectedOptions = options;
    }

    this.addonsOptions = addonsOptions ?? this.addonsOptions;
    this.quantity = quantity ?? this.quantity;
    this.isInAppPurchaseChecking =
        isInAppPurchaseChecking ?? this.isInAppPurchaseChecking;
    this.mapAttribute = mapAttribute ?? this.mapAttribute;
    notifyListeners();
  }
}
