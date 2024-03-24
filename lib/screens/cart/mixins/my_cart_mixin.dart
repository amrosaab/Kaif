import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/constants.dart';
import '../../../common/tools/biometrics_tools.dart';
import '../../../common/tools/flash.dart';
import '../../../common/tools/navigate_tools.dart';
import '../../../common/tools/price_tools.dart';
import '../../../common/tools/tools.dart';
import '../../../generated/l10n.dart';
import '../../../menu/maintab_delegate.dart';
import '../../../models/index.dart';
import '../../../routes/flux_navigate.dart';
import '../../../services/service_config.dart';
import '../../../services/services.dart';
import '../../../widgets/product/product_bottom_sheet.dart';
import '../../checkout/checkout_screen.dart';

mixin MyCartMixin<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  String errMsg = '';
  bool? get isModal;

  CartModel get cartModel => Provider.of<CartModel>(context, listen: false);

  void _loginWithResult(BuildContext context) async {
    await NavigateTools.navigateToLogin(
      context,
    );

    final user = Provider.of<UserModel>(context, listen: false).user;
    if (user != null && user.name != null) {
      Tools.showSnackBar(ScaffoldMessenger.of(context),
          '${S.of(context).welcome} ${user.name} !');
      setState(() {});
    }
  }

  Future<Widget> clearCartPopup(context) async {
    return await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(S.of(context).confirmClearTheCart),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).keep),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                cartModel.clearCart();
              },
              child: Text(
                S.of(context).clear,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> shouldShowLoginDialog(CartModel model) async {
    if (kAdvanceConfig.alwaysShowTabBar) {
      MainTabControlDelegate.getInstance()
          .changeTab(RouteList.cart, allowPush: false);
      // return;
    }

    if (model.totalCartQuantity == 0) {
      if (isModal == true) {
        try {
          ExpandingBottomSheet.of(context)!.close();
        } catch (e) {
          unawaited(Navigator.of(context).pushNamed(RouteList.dashboard));
        }
      } else {
        final modalRoute = ModalRoute.of(context);
        if (modalRoute?.canPop ?? false) {
          Navigator.of(context).pop();
        }

        MainTabControlDelegate.getInstance().changeToDefaultTab();
      }

      return;
    }

    var isLoggedIn = Provider.of<UserModel>(context, listen: false).loggedIn;

    if (isLoggedIn) {
      onCheckout(cartModel);
    } else {
      final forceLogin = await showLoginDialog(context);
      if (forceLogin != null) {
        if (forceLogin) {
          await FluxNavigate.pushNamed(
            RouteList.login,
            forceRootNavigator: true,
          );
        }

        if (!forceLogin) {
          onCheckout(cartModel);
        }
      }
    }
  }

  Future<bool?> showLoginDialog(context) async {
    return await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(S.of(context).loginToContinue),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(S.of(context).checkout),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                S.of(context).login,
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark?Colors.grey[900]:Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void onCheckout(CartModel model) {
    var isLoggedIn = Provider.of<UserModel>(context, listen: false).loggedIn;
    final appModel = Provider.of<AppModel>(context, listen: false);
    final currencyRate = appModel.currencyRate;
    final currency = appModel.currency;

    var message;

    if (isLoading) return;

    if (kCartDetail['minAllowTotalCartValue'] != null) {
      if (kCartDetail['minAllowTotalCartValue'].toString().isNotEmpty) {
        var totalValue = model.getSubTotal() ?? 0;
        var minValue = PriceTools.getCurrencyFormatted(
            kCartDetail['minAllowTotalCartValue'], currencyRate,
            currency: currency);
        if (totalValue < kCartDetail['minAllowTotalCartValue'] &&
            model.totalCartQuantity > 0) {
          message = '${S.of(context).totalCartValue} $minValue';
        }
      }
    }

    if (kVendorConfig.disableMultiVendorCheckout &&
        ServerConfig().isVendorType()) {
      if (!model.isDisableMultiVendorCheckoutValid(
          model.productsInCart, model.getProductById)) {
        message = S.of(context).youCanOnlyOrderSingleStore;
      }
    }

    if (message != null) {
      FlashHelper.errorMessage(context, message: message);
      return;
    }

    if (model.totalCartQuantity == 0) {
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

        MainTabControlDelegate.getInstance().changeToDefaultTab();
      }

      return;
    }


    if (isLoggedIn || kPaymentConfig.guestCheckout) {
      doCheckout();
    } else {
      _loginWithResult(context);
    }
  }

  Future<void> doCheckout() async {
    if (BiometricsTools.instance.isCheckoutSupported) {
      var didAuth = await BiometricsTools.instance.localAuth(context);
      if (!didAuth) {
        return;
      }
    }
    showLoading();

    await Services().widget.doCheckout(
      context,
      success: () async {
        hideLoading('');
        var manualClosed = await FluxNavigate.pushNamed(
          RouteList.checkout,
          arguments: CheckoutArgument(isModal: isModal),
          forceRootNavigator: true,
        );

        if (true == manualClosed) {
          if (isModal == true) {
            try {
              ExpandingBottomSheet.of(context)!.close();
            } catch (e) {
              if (ModalRoute.of(context)?.canPop ?? false) {
                Navigator.of(context).pop();
              } else {
                await Navigator.of(context).pushNamed(RouteList.dashboard);
              }
            }
          } else if (ModalRoute.of(context)?.canPop ?? false) {
            Navigator.of(context).pop();
          }
        }
      },
      error: (message) async {
        if (message ==
            Exception('Token expired. Please logout then login again')
                .toString()) {
          setState(() {
            isLoading = false;
          });
          //logout
          final userModel = Provider.of<UserModel>(context, listen: false);
          await userModel.logout();
          await Services().firebase.signOut();

          _loginWithResult(context);
        } else {
          hideLoading(message);
          Future.delayed(const Duration(seconds: 3), () {
            setState(() => errMsg = '');
          });
        }
      },
      loading: (isLoading) {
        setState(() {
          this.isLoading = isLoading;
        });
      },
    );
  }

  void showLoading() {
    setState(() {
      isLoading = true;
      errMsg = '';
    });
  }

  void hideLoading(error) {
    setState(() {
      isLoading = false;
      errMsg = error;
    });
  }

  void onPressedClose(String layoutType, bool? isBuyNow) {
    if (isBuyNow!) {
      Navigator.of(context).pop();
      return;
    }

    if (Navigator.of(context).canPop() &&
        ['simpleType', 'flatStyle'].contains(layoutType) == false) {
      Navigator.of(context).pop();
    } else {
      ExpandingBottomSheet.of(context, isNullOk: true)?.close();
    }
  }
}