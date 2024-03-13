import 'package:flutter/cupertino.dart';

import '../route.dart';

mixin WholesaleServiceMixin {
  dynamic getWholesaleRoutesWithSettings(RouteSettings settings) {
    return WholesaleRoute.getRoutesWithSettings(settings);
  }
}
