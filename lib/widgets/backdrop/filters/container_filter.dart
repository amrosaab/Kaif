import 'package:flutter/material.dart';

import '../../../services/index.dart';

class ContainerFilter extends StatelessWidget {
  final String? text;
  final Widget? child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  const ContainerFilter({
    Key? key,
    this.text,
    this.isSelected = false,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryBackground = Services().widget.enableProductBackdrop
        ? Colors.white
        : Theme.of(context).primaryColor.withOpacity(0.2);
    var primaryText = Theme.of(context).primaryColor;
    var secondColor = Theme.of(context).colorScheme.secondary;

    final animatedWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: margin,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? primaryText.withOpacity(0.6) : primaryBackground.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? primaryText :  secondColor.withOpacity(0.2),
          width: 0.9,
        ),
      ),
      child: Center(
        child: child ??
            Text(
              text ?? '',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color:
                        isSelected ? Colors.black : Colors.black87,
                    letterSpacing: 1.2,
                  ),
            ),
      ),
    );
    if (onSelected == null) {
      return animatedWidget;
    }

    return GestureDetector(
      onTap: () => onSelected!(!isSelected),
      child: animatedWidget,
    );
  }
}
