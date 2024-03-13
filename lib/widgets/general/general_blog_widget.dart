import 'package:flutter/material.dart';
import '../../common/config/models/general_setting_item.dart';
import 'general_widget.dart';

class GeneralBlogWidget extends GeneralWidget {
  const GeneralBlogWidget({
    required GeneralSettingItem? item,
    Color? iconColor,
    TextStyle? textStyle,
    bool useTile = false,
    Function()? onNavigator,
  }) : super(
          onNavigator: onNavigator,
          item: item,
          iconColor: iconColor,
          useTile: useTile,
          textStyle: textStyle,
        );

  @override
  void onTap(BuildContext context) {
    if (item?.blog != null) {
      onTapNavigateOptions(context: context, config: {
        'blog': item?.blog,
      });
    }
  }
}
