import 'package:flutter/material.dart';

import '../../../../common/config.dart';
import '../../../../common/theme/colors.dart';
import '../../../../common/tools.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/index.dart';
import '../../quantity_selection/quantity_selection.dart';
import '../cart_item_state_ui.dart';

class CartItemNormalWidget extends StatelessWidget {
  const CartItemNormalWidget(
    this.stateUI, {
    super.key,
    this.widthImageFeature = 100,
    this.heightImageFeature = 100,
  });

  final CartItemStateUI stateUI;

  final double widthImageFeature;
  final double heightImageFeature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        if (stateUI.enableTopDivider == true)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(color: kGrey200, height: 1),
          ),
        Row(
          key: ValueKey(stateUI.product.id),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (stateUI.onRemove != null)
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: stateUI.onRemove,
              ),
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    stateUI.onTapProduct(context, product: stateUI.product),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: widthImageFeature, //constraints.maxWidth * 0.25,
                      height: heightImageFeature, //constraints.maxWidth * 0.3,
                      child: ImageResize(url: stateUI.imageFeature),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stateUI.product.name!,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              stateUI.price!,
                              style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            if (stateUI.product.options != null &&
                                stateUI.options != null)
                              Services().widget.renderOptionsCartItem(
                                  stateUI.product, stateUI.options),
                            if (stateUI.variation != null)
                              Services().widget.renderVariantCartItem(
                                  context, stateUI.variation!, stateUI.options),
                            if (stateUI.addonsOptions?.isNotEmpty ?? false)
                              Services().widget.renderAddonsOptionsCartItem(
                                  context, stateUI.addonsOptions),
                            if (kProductDetail.showStockQuantity)
                              QuantitySelection(
                                enabled: stateUI.inStock &&
                                    stateUI.onChangeQuantity != null,
                                width: 60,
                                height: 32,
                                color: Theme.of(context).colorScheme.secondary,
                                limitSelectQuantity: stateUI.isOnBackorder
                                    ? kCartDetail['maxAllowQuantity']
                                    : stateUI.limitQuantity,
                                value: stateUI.quantity,
                                onChanged: stateUI.onChangeQuantity,
                                style: QuantitySelectionStyle.normal,
                              ),
                            if (stateUI.product.store != null &&
                                (stateUI.product.store?.name != null &&
                                    stateUI.product.store!.name!
                                        .trim()
                                        .isNotEmpty))
                              const SizedBox(height: 10),
                            if (!stateUI.inStock || stateUI.isOnBackorder)
                              const SizedBox(height: 5),
                            if (stateUI.isOnBackorder)
                              Text(S.of(context).backOrder,
                                  style: TextStyle(
                                    color: kStockColor.backorder,
                                  )),
                            if (!stateUI.isOnBackorder && !stateUI.inStock)
                              Text(
                                S.of(context).outOfStock,
                                style: const TextStyle(color: Colors.red),
                              ),
                            if (!stateUI.isOnBackorder &&
                                stateUI.inStock &&
                                stateUI.quantity != null &&
                                stateUI.quantity! > stateUI.limitQuantity)
                              Text(
                                S.of(context).quantityProductExceedInStock,
                                style: const TextStyle(color: Colors.red),
                              ),
                            if (stateUI.showStoreName)
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  stateUI.product.store?.name ?? '',
                                  style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                      fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16.0),
          ],
        ),
        if (stateUI.enableBottomDivider == true)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(color: kGrey200, height: 1),
          ),
      ],
    );
  }
}
