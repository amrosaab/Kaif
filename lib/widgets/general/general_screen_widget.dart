import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/config/models/general_setting_item.dart';
import '../../models/app_model.dart';
import 'general_widget.dart';

class GeneralScreenWidget extends GeneralWidget {
  const GeneralScreenWidget({
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
    if (item?.screen != null) {
      var config = <String, dynamic>{};
      if (item?.useTabScreen ?? false) {
        var appModel = Provider.of<AppModel>(context, listen: false);
        var tabData = appModel.appConfig?.tabBar;
        var tabIndex = tabData?.indexWhere((element) => element.layout == item?.screen);
        if (tabIndex != -1) {
          config['tab'] = item?.screen;
        }
      }
      if (config.isEmpty) {
        config['screen'] = item?.screen;
      }
      onTapNavigateOptions(context: context, config: config);
    }
  }
}