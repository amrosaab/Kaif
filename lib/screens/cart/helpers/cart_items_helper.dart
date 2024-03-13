// Move createShoppingCartRows is outside MyCart to reuse for POS
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';
import '../../../common/theme/colors.dart';
import '../../../models/cart/cart_base.dart';
import '../../../models/entities/product.dart';
import '../../../models/vendor/store_model.dart';
import '../../../services/services.dart';
import '../../../widgets/product/cart_item/cart_item.dart';
import '../../../widgets/product/cart_item/cart_item_state_ui.dart';
import '../../../widgets/vendor/store_item.dart';

List<Widget> createShoppingCartRows(
  CartModel model,
  BuildContext context,
  bool enabledTextBoxQuantity,
) {
  if (!model.isWalletCart()) {
    model.productsInCart.forEach((key, _) async {
      // Is variant product
      var productId = Product.cleanProductID(key);
      if (key.contains('-')) {
        var product = model.getProductVariationById(key);
        var updatedProduct = await Services().api.getVariationProduct(
              productId,
              product?.id,
            );
        model.updateProductVariant(key, updatedProduct);
      } else {
        // Try to load product instead of listing because the cart cannot add
        // listing products
        var updatedProduct = await Services().api.overrideGetProduct(productId);
        model.updateProduct(productId, updatedProduct);
      }
      model.updateStateCheckoutButton();
    });
  }

  var productList = {};
  var groupedItems = groupCartItems(model);
  var productListWidget = <Widget>[];
  if (groupedItems.length > 1) {
    productListWidget = groupedItems.map((GroupedStoreItems item) {
      return Column(
        children: [
          StoreCartItem(store: item.store),
          ...item.itemKeys
              .map(
                (key) => renderCartItemByKey(
                  context,
                  key,
                  model,
                  productList,
                  true,
                  enabledTextBoxQuantity,
                ),
              )
              .toList(),
          const SizedBox(height: 10.0),
          Container(color: kGrey200, height: 10),
          const SizedBox(height: 10.0),
        ],
      );
    }).toList();
  } else {
    productListWidget = model.productsInCart.keys.map(
      (key) {
        return renderCartItemByKey(
          context,
          key,
          model,
          productList,
          false,
          enabledTextBoxQuantity,
        );
      },
    ).toList();
  }

  Services().firebase.firebaseAnalytics?.logViewCart(
        currency: model.currencyCode,
        data: productList,
        price: model.getSubTotal(),
      );

  return productListWidget;
}

Widget renderCartItemByKey(
  BuildContext context,
  String key,
  CartModel model,
  Map productList,
  bool multiStore,
  bool enabledTextBoxQuantity,
) {
  var productId = Product.cleanProductID(key);
  var product = model.getProductById(productId);

  if (product != null) {
    productList[key] = {
      'id': key,
      'product': product,
      'quantity': model.productsInCart[key]
    };

    return ShoppingCartRow(
      enabledTextBoxQuantity: enabledTextBoxQuantity,
      enableBottomDivider: !multiStore,
      enableTopDivider: multiStore,
      cartStyle: kCartDetail['style'].toString().toCartStyle(),
      showStoreName: !multiStore,
      product: product,
      addonsOptions: model.productAddonsOptionsInCart[key],
      variation: model.getProductVariationById(key),
      quantity: model.productsInCart[key],
      options: model.productsMetaDataInCart[key],
      onRemove: () {
        Services().firebase.firebaseAnalytics?.logRemoveFromCart(
              currency: model.currencyCode,
              data: [productList[key]],
              price: double.tryParse(product.price ?? ''),
            );
        model.removeItemFromCart(key);
      },
      onChangeQuantity: (val) {
        var message = model.updateQuantity(product, key, val);
        if (message.isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(message),
            duration: Duration(
              milliseconds: kAdvanceConfig.timeShowToastMessage ?? 1000,
            ),
          );
          Future.delayed(
            const Duration(milliseconds: 300),
            () => ScaffoldMessenger.of(context).showSnackBar(snackBar),
          );

          return false;
        }
        return true;
      },
    );
  }
  return const SizedBox();
}

List<GroupedStoreItems> groupCartItems(
  CartModel model,
) {
  var groupedItems = <GroupedStoreItems>[];
  for (var key in model.productsInCart.keys) {
    var productId = Product.cleanProductID(key);
    var product = model.getProductById(productId);
    if (product?.store?.id != null) {
      var groupedItem = groupedItems
          .firstWhereOrNull((item) => item.store?.id == product?.store?.id);
      if (groupedItem != null) {
        groupedItem.itemKeys.add(key);
      } else {
        groupedItems
            .add(GroupedStoreItems(store: product?.store, itemKeys: [key]));
      }
    }
  }
  return groupedItems;
}

class GroupedStoreItems {
  const GroupedStoreItems({this.store, required this.itemKeys});

  final Store? store;
  final List<String> itemKeys;
}
