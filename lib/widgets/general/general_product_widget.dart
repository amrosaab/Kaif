import 'package:flutter/material.dart';
import '../../common/config/models/general_setting_item.dart';
import 'general_widget.dart';

class GeneralProductWidget extends GeneralWidget {
  const GeneralProductWidget({
    required GeneralSettingItem? item,
    Color? iconColor,
    TextStyle? textStyle,
    bool useTile = false,
    Function()? onNavigator,
  }) : super(
          item: item,
          iconColor: iconColor,
          textStyle: textStyle,
          useTile: useTile,
          onNavigator: onNavigator,
        );

  @override
  void onTap(BuildContext context) {
    if (item?.product != null) {
      onTapNavigateOptions(context: context, config: {
        'product': item?.product,
      });
    }
  }
}
