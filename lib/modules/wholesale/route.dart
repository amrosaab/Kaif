import 'package:flutter/material.dart';

import '../../common/constants.dart';
import 'views/signup_screen.dart';

class WholesaleRoute {
  static dynamic getRoutesWithSettings(RouteSettings settings) {
    final routes = {
      RouteList.wholesaleSignUp: (context) {
        return const WholesaleSignUpScreen();
      },
    };
    return routes;
  }
}
