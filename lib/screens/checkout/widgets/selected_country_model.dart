import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../common/config.dart';
import '../../../common/constants/country_phone_codes.dart';

class SelectedCountryModel extends ChangeNotifier {
  String selectedIsoCode = phoneNumecode;

  String get dialCode {
    return countryPhoneCodes.firstWhereOrNull(
            (element) => element['code'] == selectedIsoCode)?['dial_code'] ??
        kPhoneNumberConfig.dialCodeDefault;
  }

  void onInputChanged(PhoneNumber phoneNumber) {
    print("cxvxcvcxvcxvvc");
    final isoCode = phoneNumber.isoCode;
    if (isoCode != null && isoCode != selectedIsoCode) {
      phoneNumecode=isoCode;
      selectedIsoCode = isoCode;
      notifyListeners();
    }
  }
}
