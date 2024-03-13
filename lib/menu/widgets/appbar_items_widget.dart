import 'package:flutter/material.dart';

import '../../modules/dynamic_layout/config/app_config.dart';
import 'appbar_item_widget.dart';

class AppBarItemsWidget extends StatelessWidget {
  const AppBarItemsWidget({
    super.key,
    this.items,
    this.showBottom = true,
    this.popButton,
  });

  final List<AppBarItemConfig>? items;
  final bool showBottom;
  final Widget? popButton;

  @override
  Widget build(BuildContext context) {
    var widgets = items?.map(
          (AppBarItemConfig item) {
            return AppBarItemWidget(
              item: item,
              showBottom: showBottom,
            );
          },
        ).toList() ??
        <Widget>[];

    var popBtn =
        popButton != null && Navigator.canPop(context) ? popButton : null;
    if (popBtn != null) {
      widgets.add(popBtn);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}
