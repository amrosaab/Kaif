import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/constants.dart';
import '../../common/tools/tools.dart';
import '../../generated/l10n.dart';
import '../../models/index.dart' show AppModel, CartModel, Order, PaymentMethodModel, Product, TaxModel, UserModel;
import '../../services/index.dart';
import '../../widgets/common/common_safe_area.dart';
import '../../widgets/common/expansion_info.dart';
import '../../widgets/product/cart_item/cart_item.dart';
import '../base_screen.dart';
import '../cart/widgets/shopping_cart_sumary.dart';
import 'widgets/price_row_item.dart';

class ReviewScreen extends StatefulWidget {
  final Function? onBack;
  final Function? onNext;
  final Function? onFinish;
  final Function(bool)? onLoading;

  const ReviewScreen({this.onBack, this.onNext, this.onLoading, this.onFinish});

  @override
  BaseScreen<ReviewScreen> createState() => _ReviewState();
}

class _ReviewState extends BaseScreen<ReviewScreen> {
  TextEditingController note = TextEditingController();
  bool enabledShipping = kPaymentConfig.enableShipping;

  bool isPaying = false;

  String? selectedId;

  @override
  void initState() {
    var notes = Provider.of<CartModel>(context, listen: false).notes;
    note.text = notes ?? '';
    super.initState();
    Future.delayed(Duration.zero, () {
      final cartModel = Provider.of<CartModel>(context, listen: false);
      final langCode = Provider.of<AppModel>(context, listen: false).langCode;
      final token = context.read<UserModel>().user?.cookie;
      final model = Provider.of<PaymentMethodModel>(context, listen: false);
      model.getPaymentMethods(
          cartModel: cartModel,
          shippingMethod: cartModel.shippingMethod,
          token: token,
          langCode: langCode).then((value) {
        selectedId =
            model.paymentMethods.firstWhereOrNull((item) {
              if (true) {
                return item.id != 'wallet' && item.enabled!;
              } else {
                return item.enabled!;
              }
            })?.id;
      });
      setState(() {
        enabledShipping = cartModel.isEnabledShipping();
      });
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TaxModel>(context, listen: false).getTaxes(
        Provider.of<CartModel>(context, listen: false),
        Provider.of<UserModel>(context, listen: false).user?.cookie,
            (taxesTotal, taxes, isIncludingTax) {
          Provider.of<CartModel>(context, listen: false)
              .setTaxInfo(taxes, taxesTotal, isIncludingTax);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final taxModel = Provider.of<TaxModel>(context);
    final paymentMethodModel = Provider.of<PaymentMethodModel>(context);
    final cartModel = Provider.of<CartModel>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Consumer<CartModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      enabledShipping
                          ? ExpansionInfo(
                        title: S.of(context).shippingAddress,
                        children: <Widget>[
                          ShippingAddressInfo(),
                        ],
                      )
                          : const SizedBox(),
                      Container(
                        height: 1,
                        decoration: const BoxDecoration(color: kGrey200),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(S.of(context).orderDetail,
                            style: const TextStyle(fontSize: 18)),
                      ),
                      ...getProducts(model, context),
                      const ShoppingCartSummary(
                        showPrice: false,
                        showRecurringTotals: false,
                      ),
                      const SizedBox(height: 20),
                      PriceRowItemWidget(
                        title: S.of(context).subtotal,
                        total: model.getSubTotal(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Services().widget.renderShippingMethodInfo(context),
                      if (model.getCoupon() != '')
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                S.of(context).discount,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                ),
                              ),
                              Text(
                                model.getCoupon(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      Services().widget.renderTaxes(taxModel, context),
                      Services().widget.renderRewardInfo(context),
                      PriceRowItemWidget(
                        title: S.of(context).total,
                        total: model.getTotal(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Services().widget.renderRecurringTotals(context),
                      if (kEnableCustomerNote) ...[
                        const SizedBox(height: 20),
                        Text(
                          S.of(context).yourNote,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            maxLines: 5,
                            controller: note,
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                                hintText: S.of(context).writeYourNote,
                                hintStyle: const TextStyle(fontSize: 12),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        _buildBottom(paymentMethodModel, cartModel),
      ],
    );
  }

  Widget _buildBottom(PaymentMethodModel paymentMethodModel, CartModel cartModel) {

    return CommonSafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (enabledShipping || kPaymentConfig.enableAddress) ...[
            SizedBox(
              width: 130,
              child: OutlinedButton(
                onPressed: () {
                  widget.onBack!();
                },
                child: Text(
                  S.of(context).goBack.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: ButtonTheme(
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                ),
                onPressed: cartModel.enableCheckoutButton == false
                    ? null
                    : ()  {
                  final cartModel = Provider.of<CartModel>(context, listen: false);
                  /*widget.onNext!(),*/
                  if (note.text.isNotEmpty) {
                    cartModel.setOrderNotes(note.text);
                  }

                  final currencyRate =
                      Provider.of<AppModel>(context, listen: false).currencyRate;

                  widget.onLoading!(true);
                  isPaying = true;
                  if (paymentMethodModel.paymentMethods.isNotEmpty) {
                    final paymentMethod = paymentMethodModel.paymentMethods
                        .firstWhere((item) => item.id == selectedId);

                    Services().widget.placeOrder(
                      context,
                      cartModel: cartModel,
                      onLoading: widget.onLoading,
                      paymentMethod: paymentMethod,
                      success: (Order? order) async {
                        if (order != null) {
                          for (var item in order.lineItems) {
                            var product = cartModel.getProductById(item.productId!);
                            /*if (product?.bookingInfo != null) {
                                      product!.bookingInfo!.idOrder = order.id;
                                      var booking = await createBooking(product.bookingInfo)!;

                                      Tools.showSnackBar(ScaffoldMessenger.of(context),
                                          booking ? 'Booking success!' : 'Booking error!');
                                    }*/
                          }
                          widget.onFinish!(order);
                        }
                        widget.onLoading?.call(false);
                        isPaying = false;
                      },
                      error: (message) {
                        widget.onLoading?.call(false);
                        if (message != null) {
                          Tools.showSnackBar(ScaffoldMessenger.of(context), message);
                        }

                        isPaying = false;
                      },
                    );
                  }

                },
                icon: const Icon(
                  CupertinoIcons.creditcard,
                  size: 18,
                ),
                label: Text(S.of(context).continueToPayment.toUpperCase(),
                  style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily)),
                ),
              ),
            ),

        ],
      ),
    );
  }

  List<Widget> getProducts(CartModel model, BuildContext context) {
    return model.productsInCart.keys.map(
          (key) {
        var productId = Product.cleanProductID(key);

        return ShoppingCartRow(
          addonsOptions: model.productAddonsOptionsInCart[key],
          product: model.getProductById(productId),
          variation: model.getProductVariationById(key),
          quantity: model.productsInCart[key],
          options: model.productsMetaDataInCart[key],
        );
      },
    ).toList();
  }
}

class ShippingAddressInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final address = cartModel.address!;

    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        children: <Widget>[
          if (address.firstName?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).firstName,
              value: address.firstName!,
            ),
          if (address.lastName?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).lastName,
              value: address.lastName!,
            ),
          if (address.phoneNumber?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).phoneNumber,
              value: address.phoneNumber!,
            ),
          if (address.email?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).email,
              value: address.email!,
            ),
          if (address.country?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).country,
              value: address.country!,
            ),
          if (address.state?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).stateProvince,
              value: address.state!,
            ),
          if (address.city?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).city,
              value: address.city!,
            ),
          if (address.apartment?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).streetNameApartment,
              value: address.apartment!,
            ),
          if (address.block?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).streetNameBlock,
              value: address.block!,
            ),
          if (address.street?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).street,
              value: address.street!,
            ),
          if (address.zipCode?.isNotEmpty ?? false)
            _ItemInfoCheckout(
              title: S.of(context).zipCode,
              value: address.zipCode!,
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ItemInfoCheckout extends StatelessWidget {
  final String title;
  final String value;

  const _ItemInfoCheckout({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              '$title :',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}