import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inspireui/inspireui.dart';

import '../../models/entities/address.dart';
import '../../modules/dynamic_layout/config/app_config.dart';
import '../../routes/flux_navigate.dart';
import '../../widgets/common/place_picker.dart';
import '../config.dart';
import '../constants.dart';
import '../tools/navigate_tools.dart';

extension AppBarItemConfigExt on AppBarItemConfig {
  FutureOr<T?> onHandleItem<T>(BuildContext context) {
    switch (action) {
      case 'home':
        NavigateTools.navigateHome(context);
        break;
      case 'menu':
        NavigateTools.onTapOpenDrawerMenu(context);
        break;
      case 'search':
        FluxNavigate.pushNamed(RouteList.homeSearch);
        break;
      case 'cart':
        FluxNavigate.pushNamed(RouteList.cart);
        break;
      case 'location':
        return _onTapAddress(context);
      case 'wishlist':
        FluxNavigate.pushNamed(RouteList.wishlist);
        break;
      case 'notification':
        FluxNavigate.pushNamed(RouteList.notify);
        break;
      case 'product':
      case 'category':
      case 'url':
      case 'launch_url':
      case 'blog':
      case 'blog_category':
        if (actionLink?.isNotEmpty ?? false) {
          NavigateTools.onTapNavigateOptions(config: {
            action: actionLink,
          }, context: context);
        }
        break;
      default:
    }

    return null;
  }

  Future<T?> _onTapAddress<T>(BuildContext context) async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => isDesktop
            ? const PlatformError()
            : PlacePicker(
                kIsWeb
                    ? kGoogleApiKey.web
                    : isIos
                        ? kGoogleApiKey.ios
                        : kGoogleApiKey.android,
              ),
      ),
    ) as LocationResult?;

    final address = Address();

    if (result != null) {
      address.country = result.country;
      address.street = result.street;
      address.state = result.state;
      address.city = result.city;
      address.zipCode = result.zip;
      address.latitude = result.latLng?.latitude.toString();
      address.longitude = result.latLng?.longitude.toString();
      address.mapUrl =
          'https://maps.google.com/maps?q=${result.latLng?.latitude},${result.latLng?.longitude}&output=embed';

      return address as T;
    }

    return null;
  }
}
