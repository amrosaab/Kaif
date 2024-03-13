import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/tools/navigate_tools.dart';
import '../../../generated/l10n.dart';
import '../../../menu/maintab_delegate.dart';
import '../../../widgets/product/product_bottom_sheet.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({this.isModal});
  final bool? isModal;

  void _openShopping(BuildContext context) {
    if (isModal == true) {
      try {
        ExpandingBottomSheet.of(context)!.close();
      } catch (e) {
        Navigator.of(context).pushNamed(RouteList.dashboard);
      }
    } else {
      final modalRoute = ModalRoute.of(context);
      if (modalRoute?.canPop ?? false) {
        Navigator.of(context).pop();
      }
      MainTabControlDelegate.getInstance().changeTab(RouteList.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width:
              screenSize.width / (2 / (screenSize.height / screenSize.width)),
          child: Stack(
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/empty_search.png',
                  width: 120,
                  height: 120,
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(height: 160),
                  // Text(S.of(context).yourBagIsEmpty,
                  //     style: Theme.of(context).textTheme.titleMedium,
                  //     textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(S.of(context).emptyCartSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      right: 16,
                      left: 16,
                    ),
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () => _openShopping(context),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          // textStyle: const TextStyle(
                          //   letterSpacing: 0.8,
                          //   // fontSize: 11,
                          //   // fontWeight: FontWeight.w600,
                          // ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).startShopping.toUpperCase()),
                            const Icon(Icons.navigate_next, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 45,
                      child: ButtonTheme(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: const Size.fromHeight(50),
                            foregroundColor: kGrey400,
                            backgroundColor: kGrey200,
                          ),
                          onPressed: () {
                            NavigateTools.navigateToRootTab(
                              context,
                              RouteList.search,
                            );
                          },
                          child:
                              Text(S.of(context).searchForItems.toUpperCase()),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
