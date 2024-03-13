import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../common/config.dart';
import '../common/constants.dart';
import '../models/cart/cart_model.dart';
import '../services/index.dart';
import 'entities/payment_method.dart';
import 'entities/shipping_method.dart';

const kStripeApplePayMethod = 'stripe_v2_apple_pay';
const kStripeGooglePayMethod = 'stripe_v2_google_pay';

class PaymentMethodModel extends ChangeNotifier {
  final Services _service = Services();
  List<PaymentMethod> paymentMethods = [];

  bool isLoading = true;
  String? message;

  Future<void> getPaymentMethods(
      {CartModel? cartModel,
      ShippingMethod? shippingMethod,
      String? token,
      required String? langCode}) async {
    try {
      if (ServerConfig().isOpencart && paymentMethods.isNotEmpty) {
        paymentMethods = [];
      }
      isLoading = paymentMethods.isEmpty ? true : false;
      message = null;
      notifyListeners();
      paymentMethods = await _service.api.getPaymentMethods(
          cartModel: cartModel,
          shippingMethod: shippingMethod,
          token: token,
          langCode: langCode)!;

      paymentMethods.removeWhere((element) =>
          kPaymentConfig.excludedPaymentIds?.contains(element.id) ?? false);

      final isStripeSupported = paymentMethods.firstWhereOrNull((e) =>
              [...(kStripeConfig['paymentMethodIds'] ?? [])].contains(e.id)) !=
          null;
      final shouldShowApplePay = isIos &&
          kStripeConfig['enabled'] == true &&
          kStripeConfig['useV1'] != true &&
          kStripeConfig['enableApplePay'] == true &&
          ServerConfig().isPayPluginSupported;
      if (shouldShowApplePay && isStripeSupported) {
        paymentMethods.add(PaymentMethod(
          id: kStripeApplePayMethod,
          title: 'Apple Pay',
          enabled: true,
        ));
      }

      final shouldShowGooglePay = isAndroid &&
          kStripeConfig['enabled'] == true &&
          kStripeConfig['useV1'] != true &&
          kStripeConfig['enableGooglePay'] == true &&
          ServerConfig().isPayPluginSupported;
      if (shouldShowGooglePay && isStripeSupported) {
        paymentMethods.add(
          PaymentMethod(
            id: kStripeGooglePayMethod,
            title: 'Google Pay',
            enabled: true,
          ),
        );
      }

      isLoading = false;
      message = null;
      notifyListeners();
    } catch (err) {
      isLoading = false;
      message = err.toString().replaceAll('Exception: ', '');
      notifyListeners();
    }
  }
}
