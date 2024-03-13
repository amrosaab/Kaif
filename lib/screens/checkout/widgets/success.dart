import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/config.dart';
import '../../../common/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/index.dart' show Order, PointModel, UserModel;
import '../../../models/order/bank_account_item.dart';
import '../../../services/index.dart';
import '../../../widgets/common/expansion_info.dart';
import '../../base_screen.dart';
import 'price_row_item.dart';
import 'product_review.dart';

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
