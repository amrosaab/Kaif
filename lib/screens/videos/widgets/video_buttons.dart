import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/tools/flash.dart';
import '../../../generated/l10n.dart';
import '../../../routes/flux_navigate.dart';
import '../../../services/services.dart';
import '../../../widgets/product/dialog_add_to_cart.dart';
import '../models/video.dart';

const double kIconSize = 30.0;

class VideoButtons extends StatelessWidget {
  const VideoButtons({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    var inStock = video.product?.inStock ?? false;
    var allowBackorder = video.product?.backordersAllowed ?? false;
    final isExternal = video.product?.type == 'external';
    var enableBuyNow = inStock || allowBackorder || isExternal;

    return Container(
      padding: const EdgeInsets.only(right: 2, bottom: 10, left: 20, top: 10),
      child: Column(
        children: [
          if (enableBuyNow)
            VideoButton(
                icon: const Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  size: kIconSize,
                  color: Colors.white,
                ),
                label: S.of(context).buyNow,
                onTap: () => _buyNow(context)),
          if (enableBuyNow) const SizedBox(height: 15),
          VideoButton(
            icon: const Icon(
              Icons.share_sharp,
              size: kIconSize,
              color: Colors.white,
            ),
            label: S.of(context).share,
            onTap: () => _share(context),
          ),
          const SizedBox(height: 15),
          VideoButton(
            icon: const Icon(
              CupertinoIcons.arrowshape_turn_up_right_fill,
              size: kIconSize - 2,
              color: Colors.white,
            ),
            label: S.of(context).showDetails,
            onTap: () => _showDetail(context),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context) {
    FluxNavigate.pushNamed(
      RouteList.productDetail,
      arguments: video.product,
    );
  }

  void _share(BuildContext context) {
    var url = video.product?.permalink;
    if (url?.isNotEmpty ?? false) {
      unawaited(
        FlashHelper.message(
          context,
          message: S.of(context).generatingLink,
          duration: const Duration(seconds: 1),
        ),
      );
      Services().firebase.shareDynamicLinkProduct(
            itemUrl: url,
          );
    } else {
      unawaited(
        FlashHelper.errorMessage(
          context,
          message: S.of(context).failedToGenerateLink,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _buyNow(BuildContext context) {
    DialogAddToCart.show(context, product: video.product!, quantity: 1);
  }
}

class VideoButton extends StatelessWidget {
  const VideoButton({Key? key, required this.icon, this.label, this.onTap})
      : super(key: key);
  final Widget icon;
  final String? label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 5,
          bottom: 5,
        ),
        child: Column(
          children: [
            icon,
            if (label != null) const SizedBox(height: 3),
            if (label != null)
              Text(
                label ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
