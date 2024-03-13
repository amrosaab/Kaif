import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../generated/l10n.dart';
import '../../../models/entities/product.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            const Color(0xFF000000).withOpacity(0.6),
            const Color(0xFF000000).withOpacity(0.3),
            Colors.transparent
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product?.mVideoTitle ?? product?.name ?? '',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ReadMoreText(
            product?.mVideoDesc ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
            trimLines: 3,
            colorClickableText: Colors.white,
            trimMode: TrimMode.Line,
            trimCollapsedText: S.of(context).showMore,
            trimExpandedText: ' ${S.of(context).showLess}',
            lessStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.6,
                ),
            moreStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
