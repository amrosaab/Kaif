import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

import '../../../common/config.dart';
import '../../../common/constants.dart';
import '../../../common/tools/price_tools.dart';
import '../../../common/tools/tools.dart';
import '../../../generated/l10n.dart';
import '../../../models/app_model.dart';
import '../../../models/cart/cart_base.dart';
import '../../../models/entities/order_delivery_date.dart';
import '../../../models/index.dart' show Order, PointModel, UserModel;
import '../../../models/order/bank_account_item.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/shipping_method_model.dart';
import '../../../services/index.dart';
import '../../../widgets/common/common_safe_area.dart';
import '../../../widgets/common/expansion_info.dart';
import '../../base_screen.dart';
import 'date_time_picker.dart';
import 'delivery_calendar.dart';
import 'price_row_item.dart';
import 'product_review.dart';

class ShippingMethods extends StatefulWidget {
  final Function? onBack;
  final Function? onNext;
  final Function? onFinish;
  final Function(bool)? onLoading;

  const ShippingMethods({
    this.onBack,
    this.onNext,
    this.onFinish,
    this.onLoading,
  });

  @override
  State<ShippingMethods> createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<ShippingMethods> {
  int? selectedIndex = 0;

  String? selectedId;

  bool isPaying = false;

  TextEditingController note = TextEditingController();

  ShippingMethodModel get shippingMethodModel =>
      Provider.of<ShippingMethodModel>(context, listen: false);

  CartModel get cartModel => Provider.of<CartModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
    note.text = cartModel.notes ?? '';
    Future.delayed(
      Duration.zero,
          () async {
        final shippingMethod = cartModel.shippingMethod;
        final shippingMethods = shippingMethodModel.shippingMethods;
        if (shippingMethods != null &&
            shippingMethods.isNotEmpty &&
            shippingMethod != null) {
          final index = shippingMethods
              .indexWhere((element) => element.id == shippingMethod.id);
          if (index > -1) {
            setState(() {
              selectedIndex = index;
            });
          }
        }
        final langCode = Provider.of<AppModel>(context, listen: false).langCode;
        final token = context.read<UserModel>().user?.cookie;
        final model = Provider.of<PaymentMethodModel>(context, listen: false);
        model
            .getPaymentMethods(
            cartModel: cartModel,
            shippingMethod: cartModel.shippingMethod,
            token: token,
            langCode: langCode)
            .then((value) {
          selectedId = model.paymentMethods.firstWhereOrNull((item) {
            if (true) {
              return item.id != 'wallet' && item.enabled!;
            } else {
              return item.enabled!;
            }
          })?.id;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodModel = Provider.of<PaymentMethodModel>(context);
    final shippingMethodModel = Provider.of<ShippingMethodModel>(context);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).shippingMethod,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ListenableProvider.value(
                    value: shippingMethodModel,
                    child: Consumer<ShippingMethodModel>(
                      builder: (context, model, child) {
                        if (model.isLoading) {
                          return SizedBox(
                              height: 100, child: kLoadingWidget(context));
                        }

                        if (model.message != null) {
                          return SizedBox(
                            height: 100,
                            child: Center(
                                child: Text(model.message!,
                                    style: const TextStyle(color: kErrorRed))),
                          );
                        }

                        if (model.shippingMethods?.isEmpty ?? true) {
                          return Center(
                            child: Image.asset(
                              'assets/images/empty_shipping.png',
                              width: 120,
                              height: 120,
                            ),
                          );
                        }

                        return _buildShippingMethod(context, model);
                      },
                    ),
                  ),
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
                  ]
                ],
              ),
            ),
          ),
        ),
        _buildBottom(paymentMethodModel),
      ],
    );
  }

  Widget _buildShippingMethod(BuildContext context, ShippingMethodModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < model.shippingMethods!.length; i++)
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: i == selectedIndex
                      ? Theme.of(context).primaryColorLight
                      : Colors.transparent,
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: i,
                        groupValue: selectedIndex,
                        onChanged: (dynamic i) {
                          setState(() {
                            selectedIndex = i;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Services().widget.renderShippingPaymentTitle(
                                context, model.shippingMethods![i].title!),
                            const SizedBox(height: 5),
                            if (model.shippingMethods![i].cost! > 0.0 ||
                                !isNotBlank(
                                    model.shippingMethods![i].classCost))
                              Text(
                                PriceTools.getCurrencyFormatted(
                                    model.shippingMethods![i].cost! +
                                        (model.shippingMethods![i]
                                            .shippingTax ??
                                            0),
                                    cartModel.currencyRates,
                                    currency: cartModel.currencyCode)!,
                                style: const TextStyle(
                                    fontSize: 14, color: kGrey400),
                              ),
                            if (model.shippingMethods![i].cost == 0.0 &&
                                isNotBlank(model.shippingMethods![i].classCost))
                              Text(
                                model.shippingMethods![i].classCost!,
                                style: const TextStyle(
                                    fontSize: 14, color: kGrey400),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              i < model.shippingMethods!.length - 1
                  ? const Divider(height: 1)
                  : const SizedBox()
            ],
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBottom(PaymentMethodModel paymentMethodModel) {
    return CommonSafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (kPaymentConfig.enableAddress) ...[
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
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
              ),
              onPressed: () async {
                // Prevent continue to preview when loading shipping method
                if (shippingMethodModel.isLoading) {
                  return;
                }

                // Set selected shipping method
                if (shippingMethodModel.shippingMethods?.isNotEmpty ?? false) {
                  final selectedShippingMethod =
                  shippingMethodModel.shippingMethods![selectedIndex!];

                  await cartModel.setShippingMethod(selectedShippingMethod);

                  var productList = cartModel.getProductsInCart();

                  unawaited(
                      Services().firebase.firebaseAnalytics?.logAddShippingInfo(
                        coupon: cartModel.couponObj?.code,
                        currency: cartModel.currencyCode,
                        data: productList,
                        price: cartModel.getSubTotal(),
                        shippingTier: cartModel.shippingMethod?.methodTitle,
                      ));

                  //widget.onNext!();
                  /*widget.onNext!(),*/
                  if (note.text.isNotEmpty) {
                    cartModel.setOrderNotes(note.text);
                  }

                  final currencyRate =
                      Provider.of<AppModel>(context, listen: false)
                          .currencyRate;

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
                            var product =
                            cartModel.getProductById(item.productId!);
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
                          Tools.showSnackBar(
                              ScaffoldMessenger.of(context), message);
                        }

                        isPaying = false;
                      },
                    );
                  }
                  return;
                }

                // If this order doesn't need ship, we can go to the next step
                if ((shippingMethodModel.shippingMethods?.isEmpty ?? true) &&
                    (shippingMethodModel.message?.isEmpty ?? true)) {
                  //widget.onNext!();
                  final cartModel =
                  Provider.of<CartModel>(context, listen: false);
                  /*widget.onNext!(),*/
                  if (note.text.isNotEmpty) {
                    cartModel.setOrderNotes(note.text);
                  }

                  final currencyRate =
                      Provider.of<AppModel>(context, listen: false)
                          .currencyRate;

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
                            var product =
                            cartModel.getProductById(item.productId!);
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
                          Tools.showSnackBar(
                              ScaffoldMessenger.of(context), message);
                        }

                        isPaying = false;
                      },
                    );
                  }
                  return;
                }
              },
              icon: const Icon(
                Icons.checklist,
                size: 18,
              ),
              label: Text((kPaymentConfig.enableReview
                  ? S.of(context).continueToReview
                  : S.of(context).continueToPayment)
                  .toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDeliveryDate() {
    if (!(kAdvanceConfig.enableDeliveryDateOnCheckout)) {
      return const SizedBox();
    }

    Widget deliveryWidget = DateTimePicker(
      onChanged: (DateTime datetime) {
        final orderDeliveryDate = OrderDeliveryDate(datetime);
        orderDeliveryDate.dateString =
            DateFormat('dd-MM-yyyy HH:mm').format(datetime);
        cartModel.selectedDate = orderDeliveryDate;
      },
      minimumDate: DateTime.now(),
      initDate: cartModel.selectedDate?.dateTime,
      border: const OutlineInputBorder(),
    );

    if (shippingMethodModel.deliveryDates?.isNotEmpty ?? false) {
      deliveryWidget =
          DeliveryCalendar(dates: shippingMethodModel.deliveryDates!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: Tools.isRTL(context) ? 12.0 : 0.0,
              left: !Tools.isRTL(context) ? 12.0 : 0.0),
          child: Text(S.of(context).deliveryDate,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(0.7))),
        ),
        const SizedBox(height: 10),
        deliveryWidget,
        const SizedBox(height: 20),
      ],
    );
  }
}

class OrderedSuccess extends StatefulWidget {
  final Order? order;
  final String? orderNum;

  const OrderedSuccess({this.order, this.orderNum});

  @override
  BaseScreen<OrderedSuccess> createState() => _OrderedSuccessState();
}

class _OrderedSuccessState extends BaseScreen<OrderedSuccess> {
  Order? order;
  bool isLoading = false;
  ThemeData get theme => Theme.of(context);
  Color get secondaryColor => theme.colorScheme.secondary;

  Future<void> _loadOrderByNumberOrder(String numberOrder) async {
    setState(() {
      isLoading = true;
    });

    final orderDetail =
    await Services().api.getOrderByOrderId(orderId: numberOrder);

    order = orderDetail ?? Order(number: numberOrder);

    _handlePoint();

    setState(() {
      isLoading = false;
    });
  }

  void _handlePoint() {
    final user = Provider.of<UserModel>(context, listen: false).user;
    if (user != null &&
        user.cookie != null &&
        kAdvanceConfig.enablePointReward) {
      Services().api.updatePoints(user.cookie, order);
      Provider.of<PointModel>(context, listen: false).getMyPoint(user.cookie);
    }
  }

  Widget orderSummary() {
    final lineItems = order?.lineItems;
    final isWalletTopup =
        lineItems?.any((e) => e.name == 'Wallet Topup') ?? false;
    final subtotal = isWalletTopup
        ? 0.0
        : order?.subtotal ??
        lineItems?.fold(0.0, (p, e) => p! + double.parse(e.total ?? '0.0'));

    return ExpansionInfo(
      title: S.of(context).orderDetail,
      expand: true,
      children: <Widget>[
        if (order?.bacsInfo.isNotEmpty ?? false) const SizedBox(height: 20),
        ...lineItems?.map(
              (item) {
            return ProductReviewWidget(
              item: item,
              isWalletTopup: isWalletTopup,
            );
          },
        ).toList() ??
            [],
        const SizedBox(height: 16),
        if (!isWalletTopup) ...[
          PriceRowItemWidget(
            title: S.of(context).subtotal,
            total: subtotal,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: secondaryColor,
            ),
            isWalletTopup: isWalletTopup,
          ),
          PriceRowItemWidget(
            title: S.of(context).totalTax,
            total: order?.totalTax,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: secondaryColor,
            ),
            isWalletTopup: isWalletTopup,
          ),
          PriceRowItemWidget(
            title: S.of(context).shipping,
            total: order?.totalShipping,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: secondaryColor,
            ),
            isWalletTopup: isWalletTopup,
          ),
        ],
        PriceRowItemWidget(
          title: S.of(context).total,
          total: order?.total,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: secondaryColor,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
          isWalletTopup: isWalletTopup,
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.orderNum == null) {
      setState(() {
        order = widget.order;
        _handlePoint();
      });
    } else {
      _loadOrderByNumberOrder(widget.orderNum!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: theme.primaryColorLight),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).itsOrdered,
                  style: TextStyle(fontSize: 16, color: secondaryColor),
                ),
                const SizedBox(height: 5),
                if (order?.number != null)
                  Row(
                    children: <Widget>[
                      Text(
                        S.of(context).orderNo,
                        style: TextStyle(fontSize: 14, color: secondaryColor),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '#${order!.number}',
                          style: TextStyle(fontSize: 14, color: secondaryColor),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// Thai PromptPay
        /// true: show Thank you message like on the web - https://tppr.me/xrNh1
        Services().thaiPromptPayBuilder(showThankMsg: true, order: order),
        const SizedBox(height: 15),

        if (order?.bacsInfo.isNotEmpty ?? false) ...[
          Text(
            S.of(context).ourBankDetails,
            style: TextStyle(fontSize: 18, color: secondaryColor),
          ),
          ...?order?.bacsInfo.map((e) => BankAccountInfo(bankInfo: e)).toList(),
          const SizedBox(height: 15),
        ],

        if (isLoading)
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: kLoadingWidget(context),
          )
        else if (kPaymentConfig.enableOrderDetailSuccessful &&
            order != null &&
            order!.lineItems.isNotEmpty) ...[
          orderSummary(),
          const SizedBox(height: 16),
        ],

        Text(
          S.of(context).orderSuccessTitle1,
          style: TextStyle(fontSize: 18, color: secondaryColor),
        ),
        const SizedBox(height: 15),
        Text(
          S.of(context).orderSuccessMsg1,
          style: TextStyle(color: secondaryColor, height: 1.4, fontSize: 14),
        ),
        if (userModel.user != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(children: [
              Expanded(
                child: ButtonTheme(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: theme.primaryColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      final user =
                          Provider.of<UserModel>(context, listen: false).user;
                      Navigator.of(context).pushNamed(
                        RouteList.orders,
                        arguments: user,
                      );
                    },
                    child: Text(
                      S.of(context).showAllMyOrdered.toUpperCase(),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        //const SizedBox(height: 40),
        Text(
          S.of(context).orderSuccessTitle2,
          style: TextStyle(fontSize: 18, color: secondaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          S.of(context).orderSuccessMsg2,
          style: TextStyle(color: secondaryColor, height: 1.4, fontSize: 14),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              Expanded(
                child: ButtonTheme(
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      S.of(context).backToShop.toUpperCase(),
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BankAccountInfo extends StatelessWidget {
  const BankAccountInfo({Key? key, required this.bankInfo}) : super(key: key);
  final BankAccountItem bankInfo;

  @override
  Widget build(BuildContext context) {
    if ((bankInfo.accountName?.isEmpty ?? true) ||
        (bankInfo.accountNumber?.isEmpty ?? true)) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bankInfo.accountName ?? '',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(
                S.of(context).bank.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${bankInfo.bankName}',
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(
                S.of(context).accountNumber.toUpperCase(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${bankInfo.accountNumber}',
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          if (bankInfo.sortCode?.isNotEmpty ?? false) const SizedBox(height: 5),
          if (bankInfo.sortCode?.isNotEmpty ?? false)
            Row(
              children: <Widget>[
                Text(
                  S.of(context).sortCode.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${bankInfo.sortCode}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          if (bankInfo.iban?.isNotEmpty ?? false) const SizedBox(height: 5),
          if (bankInfo.iban?.isNotEmpty ?? false)
            Row(
              children: <Widget>[
                Text(
                  'IBAN',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${bankInfo.iban}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          if (bankInfo.bic?.isNotEmpty ?? false) const SizedBox(height: 5),
          if (bankInfo.bic?.isNotEmpty ?? false)
            Row(
              children: <Widget>[
                Text(
                  'BIC / Swift: ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${bankInfo.bic}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}