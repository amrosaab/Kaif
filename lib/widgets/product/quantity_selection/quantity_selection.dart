import 'dart:async';
import 'dart:math';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart' show TextEditingControllerExt, kGrey200;
import '../../../generated/l10n.dart';
import '../../../services/index.dart';
import 'layouts/quantity_selection_style02.dart';
import 'layouts/quantity_selection_style01.dart';
import 'quantity_selection_state_ui.dart';

enum QuantitySelectionStyle { normal, style01, style02 }

class QuantitySelection extends StatefulWidget {
  final int limitSelectQuantity;
  final int? value;
  final double width;
  final double height;
  final bool Function(int)? onChanged;
  final Color color;
  final bool enabled;
  final bool expanded;
  final bool enabledTextBox;
  final int? quantityStep;
  final FocusNode? focusNode;
  final QuantitySelectionStyle style;

  const QuantitySelection({
    required this.value,
    this.focusNode,
    this.width = 40.0,
    this.height = 42.0,
    this.limitSelectQuantity = 100,
    required this.color,
    this.onChanged,
    this.quantityStep,
    this.enabled = true,
    this.expanded = false,
    this.enabledTextBox = true,
    this.style = QuantitySelectionStyle.normal,
  });

  @override
  State<QuantitySelection> createState() => _QuantitySelectionState();
}

class _QuantitySelectionState extends State<QuantitySelection> {
  final _textController = TextEditingController();
  FocusNode? _focusNode;
  Timer? _debounce;

  Timer? _changeQuantityTimer;

  bool get hasChangeQuantity => widget.onChanged != null;

  void _onFocusChange() {
    if (_focusNode?.hasFocus ?? false) {
      _textController.selectAll();
    } else {
      var value = int.tryParse(_textController.text) ?? 1;
      if (value <= 0) {
        value = 1;
      }
      if (value > widget.limitSelectQuantity) {
        value = widget.limitSelectQuantity;
      }
      _textController.text = '$value';
      _onChangeQuantityData(value);
    }
  }

  int get currentQuantity => int.tryParse(_textController.text) ?? -1;

  bool _validateQuantity([int? value]) {
    if ((value ?? currentQuantity) <= 0) {
      return false;
    }
    if ((value ?? currentQuantity) > widget.limitSelectQuantity) {
      return false;
    }
    return true;
  }

  void changeQuantity(int value, {bool forceUpdate = false}) {
    if (!_validateQuantity(value)) {
      return;
    }

    if (value != currentQuantity || forceUpdate == true) {
      _textController.text = '$value';
      _onChangeQuantityData(value);
    }
  }

  void _onQuantityChanged() {
    if (!_validateQuantity()) {
      return;
    }

    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(
      const Duration(milliseconds: 300),
          () {
        _onChangeQuantityData(currentQuantity);
      },
    );
  }

  void _onChangeValueQuantity(int quantity, {void Function()? onFalse}) {
    final isChanged = widget.onChanged?.call(quantity) ?? true;
    if (isChanged == false) {
      if (onFalse != null) {
        onFalse.call();
      } else {
        setState(() {
          final value = int.tryParse(widget.value?.toString() ?? '1') ?? 1;
          _textController.text = value >= 0 ? value.toString() : '1';
        });
      }
    }
  }

  void _onChangeQuantityData(int quantity) {
    if (widget.quantityStep != null && widget.quantityStep! > 1) {
      setState(() {
        _textController.text = quantity >= 0 ? quantity.toString() : '1';
      });

      EasyDebounce.debounce(
          '_onChangeQuantityData', const Duration(milliseconds: 1500), () {
        _onChangeValueQuantity(
          quantity,
          onFalse: () {
            setState(() {
              final value = int.tryParse(_textController.text) ?? 1;
              final step = value ~/ widget.quantityStep!;
              var valueQuantity = step * widget.quantityStep!;
              valueQuantity = valueQuantity > 0 ? valueQuantity : 1;
              _textController.text = valueQuantity.toString();
              _onChangeValueQuantity(valueQuantity);
            });
          },
        );
      });
    } else {
      _onChangeValueQuantity(quantity);
    }
  }

  double _getWidth() {
    final maxItem = widget.limitSelectQuantity.toString().length;
    var minW = 20.0 + maxItem * 10;

    return max(minW, widget.width);
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.value?.toString() ?? '';
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode?.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant QuantitySelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.limitSelectQuantity != widget.limitSelectQuantity) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        changeQuantity(widget.value ?? 1, forceUpdate: true);
      });
    }
    if (oldWidget.value != null &&
        widget.value.toString() != _textController.text &&
        !(_focusNode?.hasFocus ?? false)) {
      final value = int.tryParse(widget.value?.toString() ?? '1') ?? 1;
      _textController.text = value >= 0 ? value.toString() : '1';
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onQuantityChanged);
    if (_changeQuantityTimer?.isActive ?? false) {
      _changeQuantityTimer?.cancel();
    }
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _textController.dispose();
    _focusNode?.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.style != QuantitySelectionStyle.normal) {
      final stateUI = QuantitySelectionStateUI(
        changeQuantity: (value) => changeQuantity(value),
        currentQuantity: currentQuantity,
        enabled: widget.enabled,
        expanded: widget.expanded,
        enabledTextBox: widget.enabledTextBox,
        height: widget.height,
        limitSelectQuantity: widget.limitSelectQuantity,
        onQuantityChanged: _onQuantityChanged,
        textController: _textController,
        width: _getWidth(),
        focusNode: _focusNode,
      );

      switch (widget.style) {
        case QuantitySelectionStyle.style01:
          return QuantitySelectionStyle01(
            stateUI,
            onShowOption: () => _showOptions(context),
          );
        case QuantitySelectionStyle.style02:
          return QuantitySelectionStyle02(
            stateUI,
            onShowOption: () => _showOptions(context),
          );
        default:
      }
    }

    return GestureDetector(
      onTap: () {
        if (hasChangeQuantity) {
          _showOptions(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: kGrey200),
          borderRadius: BorderRadius.circular(3),
        ),
        height: widget.height,
        width: widget.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 2.0, horizontal: (hasChangeQuantity) ? 5.0 : 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text(
                    widget.value.toString(),
                    style: TextStyle(fontSize: 14, color: widget.color),
                  ),
                ),
              ),
              if (hasChangeQuantity)
                const SizedBox(
                  width: 5.0,
                ),
              if (hasChangeQuantity)
                Icon(Icons.keyboard_arrow_down,
                    size: 14, color: Theme.of(context).colorScheme.secondary)
            ],
          ),
        ),
      ),
    );
  }

  void _showOptions(context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: !ServerConfig().isBuilder,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int option = 1;
                    option <= widget.limitSelectQuantity;
                    option++)
                      ListTile(
                          onTap: () {
                            _onChangeQuantityData(option);
                            Navigator.pop(context);
                          },
                          title: Text(
                            option.toString(),
                            textAlign: TextAlign.center,
                          )),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              decoration: const BoxDecoration(color: kGrey200),
            ),
            ListTile(
              title: Text(
                S.of(context).selectTheQuantity,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}