import 'package:flutter/material.dart';

import 'expansion_tile.dart';

class ExpansionInfo extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final bool expand;
  final List<Widget> children;

  const ExpansionInfo({
    this.title = '',
    this.titleWidget,
    required this.children,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConfigurableExpansionTile(
      initiallyExpanded: false, //expand,
      bottomBorderOn: false,
      topBorderOn: false,
      headerExpanded: Flexible(
        child: Container(
            decoration: BoxDecoration(
              color:Colors.grey[400],
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
            child: titleWidget ??
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                    ])),
      ),
      header: Flexible(
        child: titleWidget ??
            Container(
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      )
                    ])),
      ),
      children: children,
    );
  }
}
