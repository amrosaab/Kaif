import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';
import 'package:provider/provider.dart';

import '../common/constants.dart';
import '../common/tools.dart';
import '../models/index.dart';
import '../modules/dynamic_layout/config/app_config.dart';
import 'widgets/appbar_items_widget.dart';

class FluxAppBar extends StatefulWidget {
  final bool isBottom;
  final bool showBottom;
  final Widget? popButton;

  const FluxAppBar({
    Key? key,
    this.isBottom = false,
    this.showBottom = true,
    this.popButton,
  }) : super(key: key);

  @override
  State<FluxAppBar> createState() => _FluxAppBarState();
}

class _FluxAppBarState extends State<FluxAppBar> {
  @override
  Widget build(BuildContext context) {
    return Selector<AppModel, AppBarConfig?>(
      selector: (context, model) => model.appConfig?.appBar,
      shouldRebuild: (oldValue, newValue) =>
          oldValue?.toJson().toString() != newValue?.toJson().toString(),
      builder: (context, value, child) {
        if (value == null ||
            ((value.items?.isEmpty ?? true) &&
                (value.items?.isEmpty ?? true))) {
          return const SizedBox();
        }
        return Container(
          alignment: Alignment.center,
          decoration: value.backgroundColor != null
              ? BoxDecoration(
                  color: HexColor(value.backgroundColor),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!widget.isBottom)
                AppBarItemsWidget(
                  items: value.items,
                  showBottom: widget.showBottom,
                  popButton: widget.popButton,
                ),
              if (widget.isBottom && widget.showBottom)
                AppBarItemsWidget(
                  items: value.bottomItems,
                  showBottom: widget.showBottom,
                  popButton: widget.popButton,
                ),
            ],
          ),
        );
      },
    );
  }
}
