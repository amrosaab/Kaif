import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inspireui/inspireui.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../common/config.dart';
import '../../../common/tools/price_tools.dart';
import '../../../generated/l10n.dart';
import '../../../models/app_model.dart';
import '../../../models/cart/cart_base.dart';
import '../../../models/entities/product.dart';
import '../../../modules/dynamic_layout/config/cart_banner_config.dart';
import '../../../services/firebase_service.dart';
import '../../../widgets/animation/scaled_height_widget.dart';
import '../../../widgets/product/cart_item/cart_item_state_ui.dart';
import '../helpers/cart_items_helper.dart';
import '../mixins/my_cart_mixin.dart';
import '../widgets/empty_cart.dart';
import '../widgets/shopping_cart_sumary.dart';

class MyCartStyle01Layout extends StatefulWidget {
  const MyCartStyle01Layout({
    super.key,
    this.isModal,
    required this.hasNewAppBar,
    this.scrollController,
    this.isBuyNow,
    this.enabledTextBoxQuantity = true,
  });

  final bool? isBuyNow;
  final bool? isModal;
  final bool hasNewAppBar;
  final bool enabledTextBoxQuantity;
  final ScrollController? scrollController;

  @override
  State<MyCartStyle01Layout> createState() => _MyCartStyle01LayoutState();
}

class _MyCartStyle01LayoutState extends State<MyCartStyle01Layout>
    with MyCartMixin {
  @override
  bool? get isModal => widget.isModal;

  Widget buildCartBanner(CartBannerConfig? cartBannerConfig) {
    if (cartBannerConfig == null || cartBannerConfig.show == false) {
      return const SizedBox();
    }

    return ScaledHeightWidget(
      delay: Duration(milliseconds: cartBannerConfig.delayInMilliseconds),
      duration: Duration(milliseconds: cartBannerConfig.durationInMilliseconds),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 10,
          right: 16,
          bottom: 20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cartBannerConfig.borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(cartBannerConfig.borderRadius),
            onTap: () async {
              final url = cartBannerConfig.destination;
              if (url != null) {
                await FirebaseServices().dynamicLinks?.handleDynamicLink(
                  Uri.parse(url),
                  App.fluxStoreNavigatorKey.currentContext!,
                );
              }
            },
            child: CachedNetworkImage(
              imageUrl: cartBannerConfig.imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    printLog('[Cart] build');
    final appModel = Provider.of<AppModel>(context);
    var layoutType = appModel.productDetailLayout;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final cartBannerConfig = appModel.cartBannerConfig;

    return Selector<CartModel, String?>(
      selector: (_, cartModel) => cartModel.productsInCart.keys.firstOrNull,
      //add this Selector to reload cart screen when add product item to cart if the current cart has wallet item
      builder: (context, _, child) {
        return MediaQuery.removePadding(
          context: context,
          removeTop: widget.hasNewAppBar && widget.isModal != true,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Selector<CartModel, int>(
                selector: (_, cartModel) => cartModel.totalCartQuantity,
                builder: (context, totalCartQuantity, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          controller: widget.scrollController,
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              centerTitle: true,
                              elevation: 1,
                              leading: widget.isModal == true
                                  ? CloseButton(
                                onPressed: () => onPressedClose(
                                    layoutType, widget.isBuyNow),
                              )
                                  : canPop
                                  ? const BackButton()
                                  : null,
                              backgroundColor:
                              Theme.of(context).colorScheme.background,
                              actions: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 16, left: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (totalCartQuantity > 0) {
                                        clearCartPopup(context);
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/trash.png',
                                      width: 20.0,
                                      color:Theme.of(context).brightness == Brightness.dark? Colors.amber[400]:Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                              title: Text(
                                S.of(context).myCart,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: AutoHideKeyboard(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 80.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 16.0),
                                        if (totalCartQuantity > 0)
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: [
                                              buildCartBanner(cartBannerConfig),
                                              Column(
                                                children:
                                                createShoppingCartRows(
                                                  cartModel,
                                                  context,
                                                  widget.enabledTextBoxQuantity,
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const ShoppingCartSummary(
                                          showPrice: false,
                                          cartStyle: CartStyle.style01,
                                        ),
                                        if (totalCartQuantity == 0)
                                          const EmptyCart(),
                                        if (errMsg.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            child: Text(
                                              errMsg,
                                              style: const TextStyle(
                                                  color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        const SizedBox(height: 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      RenderTotalPrice(
                        isModal: widget.isModal ?? false,
                        isLoading: isLoading,
                        onCheckout: () => shouldShowLoginDialog(cartModel),
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}

class RenderTotalPrice extends StatelessWidget {
  const RenderTotalPrice({
    super.key,
    required this.isModal,
    required this.isLoading,
    required this.onCheckout,
  });

  final bool isModal;
  final bool isLoading;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<AppModel>(context).currency;
    final currencyRate = Provider.of<AppModel>(context).currencyRate;
    final smallAmountStyle =
    TextStyle(color: Theme.of(context).colorScheme.secondary);
    final defaultCurrency = kAdvanceConfig.defaultCurrency;
    final modelCart = Provider.of<CartModel>(context);

    final largeAmountStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 20,
    );

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).appBarTheme.shadowColor ??
                  Colors.grey.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, -0.5),
            )
          ]),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 15.0,
      ),
      child: SafeArea(
        top: false,
        bottom: (isModal) ? true : false,
        child: Column(
          children: [
            const SizedBox(height: 5),
            if (modelCart.totalCartQuantity != 0)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).products,
                      style: smallAmountStyle.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    'x${modelCart.totalCartQuantity}',
                    style: smallAmountStyle,
                  ),
                ],
              ),
            if (modelCart.rewardTotal > 0) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(S.of(context).cartDiscount,
                        style: smallAmountStyle),
                  ),
                  Text(
                    PriceTools.getCurrencyFormatted(
                        modelCart.rewardTotal, currencyRate,
                        currency: currency)!,
                    style: smallAmountStyle,
                  ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: modelCart.calculatingDiscount
                      ? const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  )
                      : Text(
                    PriceTools.getCurrencyFormatted(
                        modelCart.getTotal()! -
                            modelCart.getShippingCost()!,
                        currencyRate,
                        currency: modelCart.isWalletCart()
                            ? defaultCurrency?.currencyCode
                            : currency)!,
                    style: largeAmountStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ),
                Selector<CartModel, (bool, Map<String?, Product?>, bool)>(
                  selector: (_, cartModel) => (
                  cartModel.calculatingDiscount,
                  cartModel.item,
                  cartModel.enableCheckoutButton
                  ),
                  builder: (context, value, child) {
                    var calculatingDiscount = value.$1;
                    var enableCheckoutButton = value.$3;
                    var isReadyForCheckout =
                        !calculatingDiscount && enableCheckoutButton;
                    const style = TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );

                    return Selector<CartModel, int>(
                      selector: (_, cartModel) => cartModel.totalCartQuantity,
                      builder: (context, totalCartQuantity, child) {
                        return ElevatedButton.icon(

                          onPressed:
                          isReadyForCheckout ? () => onCheckout() : null,
                          icon: const Icon(Icons.login_outlined, size: 15,color:Colors.white),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[700] ,


                              elevation: 8,
                              shadowColor:
                              Theme.of(context).scaffoldBackgroundColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8)),
                          label: totalCartQuantity > 0
                              ? (isLoading
                              ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 22.0,
                          )
                              : Text(
                            S.of(context).checkout,
                            style:const TextStyle(color:Colors.white),
                          ))
                              : Text(
                            S.of(context).startShopping.toUpperCase(),
                            style:TextStyle(color:   Theme.of(context).brightness == Brightness.dark?Colors.grey[900]:Colors.white),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
