import 'package:flutter/material.dart';
import 'package:multiple_localization/multiple_localization.dart';

import '../intl/messages_all.dart';
import '../l10n.dart';

class AppLocalization extends S {
  static const SDelegate delegate = SDelegate();
}

class SDelegate extends AppLocalizationDelegate {
  const SDelegate();

  @override
  Future<S> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages, locale, (l) => S.load(Locale(l)),
        setDefaultLocale: true);
  }
}
