import 'package:flutter/material.dart';
import 'package:inspireui/icons/icon_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/config/models/general_setting_item.dart';
import '../../common/constants.dart';
import '../../common/tools/navigate_tools.dart';
import '../../common/tools/tools.dart';
import '../../generated/l10n.dart';
import '../../models/entities/product.dart';
import '../../routes/flux_navigate.dart';

abstract class GeneralWidget extends StatelessWidget {
  final bool useTile;
  final Color? iconColor;
  final TextStyle? textStyle;
  final GeneralSettingItem? item;
  final void Function()? onNavigator;

  const GeneralWidget({
    required this.item,
    this.iconColor,
    this.textStyle,
    this.useTile = false,
    this.onNavigator,
  });

  void onTapNavigateOptions({
    BuildContext? context,
    required Map config,
    List<Product>? products,
  }) {
    onNavigator?.call();
    NavigateTools.onTapNavigateOptions(
      config: config,
      context: context,
      products: products,
    );
  }

  void onPushScreen(Widget screen) {
    onNavigator?.call();
    FluxNavigate.push(MaterialPageRoute(builder: (context) => screen));
  }

  void onLaunch(String? webUrl) {
    Tools.launchURL(
      webUrl,
      mode: LaunchMode.externalApplication,
    );
  }

  void onTap(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    var icon = Icons.error;
    String title;
    Widget trailing;
    title = item?.title ?? S.of(context).dataEmpty;
    trailing = const Icon(Icons.arrow_forward_ios, size: 18, color: kGrey600);
    if (item != null) {
      icon = iconPicker(item!.icon, item!.iconFontFamily) ?? Icons.error;
    }
    if (useTile) {
      return ListTile(
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(
          title,
          style: textStyle,
        ),
        onTap: () => onTap(context),
      );
    }

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 2.0),
          elevation: 0,
          child: ListTile(
            leading: Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
              size: 24,
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: trailing,
            onTap: () => onTap(context),
          ),
        ),
        const Divider(
          color: Colors.black12,
          height: 1.0,
          indent: 75,
          //endIndent: 20,
        ),
      ],
    );
  }
}
