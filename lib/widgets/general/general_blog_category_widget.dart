import 'package:flutter/material.dart';

import '../../common/config/models/general_setting_item.dart';
import 'general_widget.dart';

class GeneralBlogCategoryWidget extends GeneralWidget {
  const GeneralBlogCategoryWidget({
    bool useTile = false,
    Color? iconColor,
    TextStyle? textStyle,
    GeneralSettingItem? item,
    Function()? onNavigator,
  }) : super(
          onNavigator: onNavigator,
          useTile: useTile,
          iconColor: iconColor,
          textStyle: textStyle,
          item: item,
        );

  @override
  void onTap(BuildContext context) {
    if (item?.blogCategory != null) {
      onTapNavigateOptions(context: context, config: {
        'blog_category': item?.blogCategory,
      });
    }
  }
}
