import 'package:flutter/material.dart';
import 'package:inspireui/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../models/category/category_model.dart';
import '../../../widgets/common/flux_image.dart';
import '../index.dart';
import 'common_item_extension.dart';

class CategoryIconItem extends StatelessWidget {
  final double? iconSize;
  final String? name;
  final Function? onTap;
  final CategoryItemConfig? itemConfig;
  final CommonItemConfig commonConfig;
  final bool? isSelected;
  final bool isHorizontal;
  final bool isWrap;

  const CategoryIconItem({
    this.iconSize,
    this.name,
    this.onTap,
    this.itemConfig,
    this.isSelected,
    required this.commonConfig,
    this.isHorizontal = false,
    this.isWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final disableBackground =
        (commonConfig.noBackground ?? false) || commonConfig.originalColor;
    final categoryList = Provider.of<CategoryModel>(context).categoryList;

    final id = itemConfig?.category.toString();
    final categoryName =
        name ?? (categoryList[id] != null ? categoryList[id]!.name : '');
    final image = itemConfig?.image ??
        (categoryList[id] != null ? categoryList[id]!.image : null);
    final firstColor = (itemConfig?.colors?.isNotEmpty ?? false)
        ? itemConfig?.colors?.first
        : null;

    return GestureDetector(
      onTap: () => onTap?.call(categoryName),
      child: Container(
        constraints: isHorizontal || iconSize == null
            ? null
            : BoxConstraints(maxWidth: iconSize! * 1.2),
        decoration: commonConfig.border != null && commonConfig.border != 0
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: commonConfig.border!,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  right: BorderSide(
                    width: commonConfig.border!,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: commonConfig.imageDecoration,
              width: isHorizontal
                  ? isWrap
                      ? double.infinity
                      : null
                  : iconSize,
              height: iconSize,
              padding: EdgeInsets.all(commonConfig.imageSpacing),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: commonConfig.paddingX,
                  vertical: commonConfig.paddingY,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: commonConfig.marginX,
                  vertical: commonConfig.marginY,
                ),
                decoration: BoxDecoration(
                  color: !disableBackground
                      ? itemConfig?.getBackgroundColor
                      : null,
                  gradient:
                      !disableBackground ? itemConfig?.getGradientColor : null,
                  boxShadow: [
                    if (commonConfig.boxShadow != null)
                      BoxShadow(
                        blurRadius: commonConfig.boxShadow!.blurRadius,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(commonConfig.boxShadow!.colorOpacity),
                        offset: Offset(commonConfig.boxShadow!.x,
                            commonConfig.boxShadow!.y),
                      )
                  ],
                  borderRadius:
                      BorderRadius.circular(commonConfig.radius ?? 10),
                ),
                child: (isHorizontal == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (image != null)
                            SizedBox(child: _image(image, firstColor)),
                          Flexible(
                            child: Text(
                              categoryName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: commonConfig.labelFontSize),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    : (image != null)
                        ? Container(
                            margin: EdgeInsets.all(commonConfig.spacing),
                            child: _image(image, firstColor),
                          )
                        : const SizedBox(),
              ),
            ),
            if ((categoryName?.isNotEmpty) ?? false) ...[
              const SizedBox(height: 6),
              if (isHorizontal == false)
                Text(
                  categoryName!,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: commonConfig.labelFontSize,
                      ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              if (isSelected != null)
                AnimatedContainer(
                  decoration: BoxDecoration(
                    color: isSelected == true
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  margin: const EdgeInsets.only(
                    top: 4.0,
                  ),
                  height: 4.0,
                  width: 4.0,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _image(String image, HexColor? firstColor) {
    return FluxImage(
      imageUrl: image,
      color: (itemConfig?.originalColor ?? true) || commonConfig.originalColor
          ? null
          : firstColor,
      width: iconSize,
      height: iconSize,
    );
  }
}
