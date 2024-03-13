import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../models/cart/cart_base.dart';
import '../../widgets/common/loading_body.dart';
import '../common/app_bar_mixin.dart';
import 'my_cart_screen.dart';

class CartScreenArgument {
  final bool isModal;
  final bool isBuyNow;
  final bool hideNewAppBar;

  CartScreenArgument({
    required this.isModal,
    required this.isBuyNow,
    this.hideNewAppBar = false,
  });
}

class CartScreen extends StatefulWidget {
  final bool? isModal;
  final bool isBuyNow;
  final bool hideNewAppBar;
  final bool enabledTextBoxQuantity;

  const CartScreen({
    this.isModal,
    this.isBuyNow = false,
    this.hideNewAppBar = false,
    this.enabledTextBoxQuantity = true,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AppBarMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    screenScrollController = _scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return AutoHideKeyboard(
      child: renderScaffold(
        routeName: RouteList.cart,
        hideNewAppBar: widget.hideNewAppBar,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Selector<CartModel, bool>(
          selector: (_, cartModel) => cartModel.calculatingDiscount,
          builder: (context, calculatingDiscount, child) {
            return LoadingBody(
              isLoading: calculatingDiscount,
              child: child!,
            );
          },
          child: MyCart(
            isBuyNow: widget.isBuyNow,
            enabledTextBoxQuantity: widget.enabledTextBoxQuantity,
            isModal: widget.isModal,
            scrollController: _scrollController,
            hasNewAppBar: showAppBar(RouteList.cart),
          ),
        ),
      ),
    );
  }
}