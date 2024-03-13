import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/constants.dart';
import '../quantity_selection_state_ui.dart';

class QuantitySelectionStyle01 extends StatelessWidget {
  const QuantitySelectionStyle01(
      this.stateUI, {
        super.key,
        this.onShowOption,
      });

  final QuantitySelectionStateUI stateUI;
  final void Function()? onShowOption;

  @override
  Widget build(BuildContext context) {
    final heightItem = stateUI.height;

    final iconPadding = EdgeInsets.all(
      max(
        ((heightItem) - 24.0 - 8) * 0.5,
        0.0,
      ),
    );
    final enableTextBox = stateUI.enabled == true && stateUI.enabledTextBox;

    final textField = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: enableTextBox ? null : onShowOption,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.only(bottom: 2),
        height: heightItem,
        width: stateUI.expanded == true ? null : stateUI.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: kGrey200),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: TextField(
          focusNode: stateUI.focusNode,
          readOnly: stateUI.enabled == false || stateUI.enabledTextBox == false,
          enabled: enableTextBox,
          controller: stateUI.textController,
          maxLines: 1,
          maxLength: '${stateUI.limitSelectQuantity}'.length,
          onChanged: (_) => stateUI.onQuantityChanged(),
          onSubmitted: (_) => stateUI.onQuantityChanged(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            contentPadding: EdgeInsets.only(bottom: 12.5, left: 4),
          ),
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: false,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textAlign: TextAlign.center,
        ),
      ),
    );
    return Row(
      children: [
        stateUI.enabled == true
            ? Container(
          height: heightItem,
          width: heightItem,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: IconButton(
            padding: iconPadding,
            onPressed: () {
              if (stateUI.focusNode?.hasFocus ?? false) {
                stateUI.focusNode?.unfocus();
              }
              stateUI.changeQuantity(stateUI.currentQuantity - 1);
            },
            icon: Icon(
              Icons.remove,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
            : const SizedBox.shrink(),
        stateUI.expanded == true
            ? Expanded(
          child: textField,
        )
            : textField,
        stateUI.enabled == true
            ? Container(
          height: heightItem,
          width: heightItem,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: IconButton(
            padding: iconPadding,
            onPressed: () {
              if (stateUI.focusNode?.hasFocus ?? false) {
                stateUI.focusNode?.unfocus();
              }
              stateUI.changeQuantity(stateUI.currentQuantity + 1);
            },
            icon: Icon(
              Icons.add,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}