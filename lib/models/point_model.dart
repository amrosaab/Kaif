import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/extensions/num_ext.dart';
import '../services/index.dart';
import 'cart/cart_base.dart';
import 'entities/point.dart';

class PointModel extends ChangeNotifier {
  final Services _service = Services();
  Point? point;
  int? cartPointsRate, maxPointDiscount;
  double? cartPriceRate, maxPriceDiscount;

  bool get isAvailableReward =>
      point != null &&
      cartPointsRate.isNotNullAndNotZero &&
      cartPriceRate.isNotNullAndNotZero &&
      point!.maxPointDiscount != null;

  Future<void> getMyPoint(String? token) async {
    try {
      point = await _service.api.getMyPoint(token);
      if (point != null) {
        cartPointsRate = point!.cartPointsRate;
        cartPriceRate = point!.cartPriceRate;
      }
    } catch (err) {
      printLog('getMyPoint $err');
    }
    notifyListeners();
  }

  double getMaxPointsDiscount(double totalBill) {
    if (isAvailableReward == false) {
      return 0;
    }

    final maxPointDiscount = point!.maxPointDiscount!;

    if (maxPointDiscount.contains('%')) {
      var percentDiscount =
          double.tryParse(maxPointDiscount.replaceAll('%', '')) ?? 0;
      return percentDiscount *
          totalBill /
          100 *
          cartPointsRate! /
          cartPriceRate!;
    }

    return double.tryParse(maxPointDiscount) ?? 0;
  }

  void updateRewardDiscount(CartModel cartModel) {
    final subTotal = cartModel.getSubTotal() ?? 0;

    if (cartPointsRate.isNotNullAndNotZero && cartPriceRate != null) {
      maxPriceDiscount =
          getMaxPointsDiscount(subTotal) * cartPriceRate! / cartPointsRate!;
      maxPointDiscount = getMaxPointsDiscount(subTotal).ceil();
    }
  }

  double totalReward(double appliedPoints) {
    var total = 0.0;
    if (isAvailableReward == false) {
      return 0;
    }

    if (maxPointDiscount!.ceil() == appliedPoints.toDouble()) {
      total = maxPriceDiscount ?? 0;
    } else {
      total = appliedPoints * cartPriceRate! / cartPointsRate!;
    }

    return total;
  }
}
