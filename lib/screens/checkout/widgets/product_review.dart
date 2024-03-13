import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/tools/price_tools.dart';
import '../../../models/index.dart';
import '../../../widgets/common/flux_image.dart';
import '../../../widgets/product/quantity_selection/quantity_selection.dart';

const _kProductItemHeight = 100.0;

class ProductReviewWidget extends StatelessWidget {
  final ProductItem item;
  final bool isWalletTopup;

  const ProductReviewWidget({
    super.key,
    required this.item,
    this.isWalletTopup = false,
  });

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: false);
    final currencyRate = appModel.currencyRate;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Container(
      height: _kProductItemHeight,
      margin: const EdgeInsetsDirectional.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: FluxImage(
              imageUrl: item.product?.imageFeature ?? '',
              fit: BoxFit.fitHeight,
              width: _kProductItemHeight,
              height: _kProductItemHeight,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  item.name ?? '',
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),
                Text(
                  PriceTools.getCurrencyFormatted(
                    item.total ?? 0.0,
                    currencyRate,
                    currency: isWalletTopup
                        ? kAdvanceConfig.defaultCurrency?.currencyCode
                        : Provider.of<CartModel>(context, listen: false)
                        .currencyCode,
                  )!,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                QuantitySelection(
                  enabled: false,
                  color: secondaryColor,
                  value: item.quantity,
                  style: QuantitySelectionStyle.normal,
                  width: 60,
                  height: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}