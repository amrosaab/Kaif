import 'package:flutter/material.dart';

import '../../common/config/models/general_setting_item.dart';
import '../../common/tools.dart';
import '../common/flux_image.dart';
import 'general_widget.dart';

class GeneralButtonWidget extends GeneralWidget {
  const GeneralButtonWidget({
    required GeneralSettingItem? item,
    Function()? onNavigator,
  }) : super(
          onNavigator: onNavigator,
          item: item,
        );

  Widget renderButtonItem(BuildContext context, GeneralButton item) {
    if (item.image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(item.radius.toDouble()),
        child: FluxImage(
          imageUrl: item.image!,
          width: item.width.toDouble(),
          height: item.height.toDouble(),
        ),
      );
    } else {
      return Container(
        width: item.width.toDouble(),
        height: item.height.toDouble(),
        alignment: Alignment.centerLeft,
        child: Text(
          item.text ?? '',
          style: TextStyle(
            color: item.textColor != null ? HexColor(item.textColor) : null,
            fontSize: item.textFontSize.toDouble(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemVal = item ?? GeneralSettingItem();
    var buttons = itemVal.buttons;

    return Align(
      alignment: itemVal.displayButtonAlignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            buttons.length,
            (index) => InkWell(
              onTap: () => onTapNavigateOptions(
                  context: context, config: buttons[index].navigator),
              child: Container(
                  margin: EdgeInsets.only(
                    left: buttons[index].marginLeft.toDouble(),
                    right: buttons[index].marginRight.toDouble(),
                  ),
                  child: renderButtonItem(context, buttons[index])),
            ),
          ),
        ),
      ),
    );
  }
}
