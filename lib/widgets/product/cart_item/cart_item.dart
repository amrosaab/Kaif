import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../generated/l10n.dart';
import '../../../models/cart/cart_base.dart';
import '../../../models/entities/index.dart' show AddonsOption;
import '../../../models/index.dart' show AppModel, Product, ProductVariation;
import '../../../services/index.dart';
import '../action_button_mixin.dart';
import 'cart_item_state_ui.dart';
import 'layouts/cart_item_normal_widget.dart';
import 'layouts/cart_item_style01_widget.dart';

class ShoppingCartRow extends StatelessWidget with ActionButtonMixin {
  const ShoppingCartRow({
    required this.product,
    required this.quantity,
    this.onRemove,
    this.onChangeQuantity,
    this.variation,
    this.options,
    this.addonsOptions,
    this.enableTopDivider,
    this.enableBottomDivider = true,
    this.showStoreName = true,
    this.enabledTextBoxQuantity = true,
    this.cartStyle = CartStyle.normal,
  });

  final bool? enableTopDivider;
  final bool enableBottomDivider;
  final bool enabledTextBoxQuantity;
  final Product? product;
  final List<AddonsOption>? addonsOptions;
  final ProductVariation? variation;
  final Map? options;
  final int? quantity;
  final bool Function(int value)? onChangeQuantity;
  final VoidCallback? onRemove;
  final bool showStoreName;
  final CartStyle cartStyle;

  void _onRemoveItem(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(S.of(context).confirmRemoveProductInCart),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).keep),
            ),
            ElevatedButton(
              style:  ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).brightness == Brightness.dark? const Color(0xff282D39):Colors.grey[700],
        ),
              onPressed: () {
                Navigator.of(context).pop();
                onRemove?.call();
              },
              child: Text(
                S.of(context).remove,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currency = Provider.of<AppModel>(context).currency;
    final currencyRate = Provider.of<AppModel>(context).currencyRate;

    return Selector<CartModel, Product?>(
      selector: (_, cartModel) => cartModel.item[product?.id],
      builder: (context, product, __) {
        if (product == null) {
          return const SizedBox();
        }

        final price = Services().widget.getPriceItemInCart(
            product, variation, currencyRate, currency,
            selectedOptions: addonsOptions);
        final imageFeature = (variation?.imageFeature?.isNotEmpty ?? false)
            ? variation!.imageFeature
            : product.imageFeature;
        var maxQuantity = kCartDetail['maxAllowQuantity'] ?? 100;
        var totalQuantity = variation != null
            ? (variation!.stockQuantity ?? maxQuantity)
            : (product.stockQuantity ?? maxQuantity);
        var limitQuantity =
        totalQuantity > maxQuantity ? maxQuantity : totalQuantity;
        final inStock =
            (variation != null ? variation!.inStock : product.inStock) ?? false;
        final isOnBackorder = variation != null
            ? variation?.backordersAllowed ?? false
            : product.backordersAllowed;

        final stateUI = CartItemStateUI(
          enableBottomDivider: enableBottomDivider,
          inStock: inStock,
          isOnBackorder: isOnBackorder,
          onTapProduct: onTapProduct,
          product: product,
          showStoreName: showStoreName,
          addonsOptions: addonsOptions,
          enableTopDivider: enableTopDivider,
          imageFeature: imageFeature,
          limitQuantity: limitQuantity,
          enabledTextBoxQuantity: enabledTextBoxQuantity,
          onChangeQuantity: onChangeQuantity,
          onRemove: () => _onRemoveItem(context),
          options: options,
          price: price,
          quantity: quantity,
          variation: variation,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            switch (cartStyle) {
              case CartStyle.style01:
                return CartItemStyle01Widget(
                  stateUI,
                  constraintsCurrent: constraints,
                );
              case CartStyle.normal:
              default:
                return CartItemNormalWidget(
                  stateUI,
                  heightImageFeature: constraints.maxWidth * 0.3,
                  widthImageFeature: constraints.maxWidth * 0.25,
                );
            }
          },
        );
      },
    );
  }
}