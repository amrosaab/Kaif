import 'package:country_pickers/utils/utils.dart';

import '../../common/constants.dart';
import '../../common/typedefs.dart';

class Address {
  String? firstName;
  String? lastName;
  String? email;
  String? street;
  String? apartment;
  String? block;
  String? block2;
  String? city;
  String? state;
  String? province;
  String? sector;
  String? country;
  String? countryId;
  String? phoneNumber;
  String? fullAddress;
  String? zipCode;
  String? mapUrl;
  String? latitude;
  String? longitude;

  Address({
    this.firstName,
    this.lastName,
    this.email,
    this.street,
    this.apartment,
    this.block,
    this.block2,
    this.city,
    this.province,
    this.sector,
    this.state,
    this.country,
    this.phoneNumber,
    this.fullAddress,
    this.zipCode,
    this.mapUrl,
    this.latitude,
    this.longitude,
  });

  Address.fromJson(Map parsedJson) {
    firstName = parsedJson['first_name'] ?? '';
    lastName = parsedJson['last_name'] ?? '';
    apartment = parsedJson['company'] ?? '';
    street = parsedJson['address_1'] ?? '';
    block = parsedJson['address_2'] ?? '';
    city = parsedJson['city'] ?? '';
    state = parsedJson['state'] ?? '';
    country = parsedJson['country'] ?? '';
    email = parsedJson['email'] ?? '';
    province = parsedJson['province'] ?? '';
    sector = parsedJson['sector'] ?? '';
    // final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    // if (alphanumeric.hasMatch(firstName!)) {
    //   phoneNumber = firstName;
    // }
    phoneNumber = parsedJson['phone'] ?? '';
    fullAddress = parsedJson['full_address'] ?? '';
    zipCode = parsedJson['postcode'];
  }

  Address.fromOpencartJson(Map parsedJson) {
    firstName = parsedJson['firstname'];
    lastName = parsedJson['lastname'];
    apartment = parsedJson['company'];
    street = parsedJson['address_1'];
    block = parsedJson['address_2'];
    city = parsedJson['city'];
    state = parsedJson['zone_id'];
    country = parsedJson['country_id'];
    fullAddress = parsedJson['full_address'];
    zipCode = parsedJson['postcode'];
    province = parsedJson['province'] ?? '';
    sector = parsedJson['sector'] ?? '';
  }

  Address.fromMagentoJson(Map<String, dynamic> parsedJson) {
    firstName = parsedJson['firstname'];
    lastName = parsedJson['lastname'];
    if (parsedJson['street'] != null) {
      var streets = List.from(parsedJson['street']);
      street = streets.isNotEmpty ? streets[0] : '';
      block = streets.length > 1 ? streets[1] : '';
    }

    city = parsedJson['city'];
    state = parsedJson['region'];
    country = parsedJson['country_id'];
    email = parsedJson['email'];
    phoneNumber = parsedJson['telephone'];
    fullAddress = parsedJson['full_address'];
    zipCode = parsedJson['postcode'];
    province = parsedJson['province'] ?? '';
    sector = parsedJson['sector'] ?? '';
  }

  Address.fromPrestaJson(Map<String, dynamic> parsedJson) {
    firstName = parsedJson['firstname'];
    lastName = parsedJson['lastname'];
    street = parsedJson['address1'];
    block = parsedJson['address2'];
    city = parsedJson['city'];
    country = parsedJson['id_country'];
    phoneNumber = parsedJson['phone'];
    fullAddress = parsedJson['full_address'];
    zipCode = parsedJson['postcode'];
    province = parsedJson['province'] ?? '';
    sector = parsedJson['sector'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var address = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'address_1': street ?? '',
      'address_2': block ?? '',
      'block2': block2 ?? '',
      'company': apartment ?? '',
      'city': city,
      'state': state,
      'country': country,
      'phone': phoneNumber,
      'full_address': fullAddress,
      'postcode': zipCode,
      'mapUrl': mapUrl,
      'sector': sector,
      'province': province,
    };
    if (email != null && email!.isNotEmpty) {
      address['email'] = email;
    }
    return address;
  }

  Map<String, dynamic> toWCFMJson() {
    var address = toJson();
    if (street?.isNotEmpty ?? false) {
      address['wcfmmp_user_location'] = street;
    }
    if (latitude?.isNotEmpty ?? false) {
      address['wcfmmp_user_location_lat'] = latitude;
    }
    if (longitude?.isNotEmpty ?? false) {
      address['wcfmmp_user_location_lng'] = longitude;
    }
    return address;
  }

  Address.fromLocalJson(Map json) {
    try {
      firstName = json['first_name'];
      lastName = json['last_name'];
      street = json['address_1'];
      block = json['address_2'];
      block2 = json['block2'];
      apartment = json['company'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      email = json['email'];
      phoneNumber = json['phone'];
      fullAddress = json['full_address'];
      zipCode = json['postcode'];
      mapUrl = json['mapUrl'];

      province = json['province'] ?? '';
      sector = json['sector'] ?? '';

    } catch (e) {
      printLog(e.toString());
    }
  }

  Map<String, dynamic> toMagentoJson() {
    return {
      'address': {
        'region': state,
        'country_id': country,
        'region_id': state != null && int.tryParse(state!) != null
            ? int.parse(state!)
            : 0,
        'street': [
          street,
          '$apartment${(block?.isEmpty ?? true) ? '' : ' - $block'}',
        ],
        'full_address': fullAddress,
        'postcode': zipCode,
        'city': city,
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'telephone': phoneNumber,
        'sector': sector,
        'province': province,
        'same_as_billing': 1
      }
    };
  }

  Map<String, dynamic> toOpencartJson() {
    return {
      'zone_id': state,
      'country_id': countryId ?? country,
      'address_1': street ?? '',
      'address_2': block ?? '',
      'company': apartment ?? '',
      'full_address': fullAddress,
      'postcode': zipCode,
      'city': city,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'telephone': phoneNumber,
      'sector': sector,
      'province': province,
    };
  }

  bool isValid() {
    return firstName!.isNotEmpty &&
        lastName!.isNotEmpty &&
        email!.isNotEmpty &&
        street!.isNotEmpty &&
        city!.isNotEmpty &&
        state!.isNotEmpty &&
        country!.isNotEmpty &&
        phoneNumber!.isNotEmpty;
  }

  bool isValidWithFullAddress() {
    return firstName!.isNotEmpty &&
        lastName!.isNotEmpty &&
        email!.isNotEmpty &&
        fullAddress!.isNotEmpty &&
        city!.isNotEmpty &&
        state!.isNotEmpty &&
        country!.isNotEmpty &&
        phoneNumber!.isNotEmpty;
  }

  Map<String, String?> toJsonEncodable() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'address_1': street ?? '',
      'address_2': block ?? '',
      'company': apartment ?? '',
      'city': city,
      'state': state,
      'country': country,
      'email': email,
      'phone': phoneNumber,
      'full_address': fullAddress,
      'postcode': zipCode,
      'mapUrl': mapUrl,
      'sector': sector,
      'province': province,
    };
  }

  Address.fromShopifyJson(Map json) {
    try {
      firstName = json['firstName'];
      lastName = json['lastName'];
      street = json['address1'];
      block = json['address2'];
      apartment = json['company'];
      city = json['city'];
      state = json['province'];
      sector = json['sector'];

      country = json['country'];
      email = json['email'];
      phoneNumber = json['phone'];
      fullAddress = json['full_address'];
      zipCode = json['zip'];
    } catch (e) {
      printLog(e.toString());
    }
  }

  Map<String, dynamic> toShopifyJson({FormatAddress? formatAddress}) {
    return {
      'address': {
        'country': country,
        'company': apartment,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phoneNumber,
        'zip': zipCode,
           if (formatAddress != null)
            ...formatAddress(
              province: state!=null&&state!.isNotEmpty?state: city,
              city: city,
            street: street,
            province2: province,
            sector:sector,
            block: block,
            block2: block2,
            apartment: apartment,
            fullAddress: fullAddress,
            zipCode: zipCode,
          )
      }
    };
  }

  Address.fromOpencartOrderJson(Map json) {
    try {
      firstName = json['shipping_firstname'];
      lastName = json['shipping_lastname'];
      street = json['shipping_address_1'];
      block = json['shipping_address_2'];
      apartment = json['shipping_company'];
      city = json['shipping_city'];
      state = json['shipping_zone'];
      country = json['shipping_country'];
      email = json['email'];
      phoneNumber = json['telephone'];
      fullAddress = json['full_address'];
      zipCode = json['shipping_postcode'];
    } catch (e) {
      printLog(e.toString());
    }
  }

  Address.fromBigCommerceJson(Map json) {
    try {
      firstName = json['first_name'];
      lastName = json['last_name'];
      apartment = json['company'];
      street = json['street_1'];
      block = json['street_2'];
      city = json['city'];
      state = json['state'];
      fullAddress = json['full_address'];
      zipCode = json['zip'];
      country = json['country'];
      countryId = json['country_iso2'];
      phoneNumber = json['phone'];
      email = json['email'];
    } catch (e) {
      printLog(e.toString());
    }

    //   Map<String, dynamic> toBigCommerceJson() {
    //     final data = <String, dynamic>{};
    //     data['first_name'] = firstName;
    //     data['last_name'] = lastName;
    //     data['company'] = apartment;
    //     data['street_1'] = street;
    //     data['street_2'] = block;
    //     data['city'] = city;
    //     data['state'] = state;
    //     data['zip'] = zipCode;
    //     data['country'] = country;
    //     data['country_iso2'] = countryId;
    //     data['phone'] = phoneNumber;
    //     data['email'] = email;
    //     return data;
    //   }
  }

  @override
  String toString() {
    var output = '';
    if (street != null) {
      output += ' $street';
    }
    if (country != null) {
      output += ' $country';
    }
    if (city != null) {
      output += ' $city';
    }

    return output.trim();
  }

  String get fullName => [firstName ?? '', lastName ?? ''].join(' ').trim();

  String get fullInfoAddress {
    var info = [];
    if (street?.isNotEmpty ?? false) {
      info.add(street);
    }

    if (block?.isNotEmpty ?? false) {
      info.add(block);
    }

    if (apartment?.isNotEmpty ?? false) {
      info.add(apartment);
    }

    if (city?.isNotEmpty ?? false) {
      info.add(city);
    }

    if (country?.isNotEmpty ?? false) {
      info.add(_getCountryName(country));
    }

    var address = info.join(', ');
    if (zipCode?.isNotEmpty ?? false) {
      address = '$address - $zipCode';
    }

    return address;
  }

  String _getCountryName(country) {
    try {
      return CountryPickerUtils.getCountryByIsoCode(country).name;
    } catch (err) {
      return country;
    }
  }

  Address copyWith({
    String? Function()? firstName,
    String? Function()? lastName,
    String? Function()? email,
    String? Function()? street,
    String? Function()? apartment,
    String? Function()? block,
    String? Function()? block2,
    String? Function()? city,
    String? Function()? state,
    String? Function()? country,
    String? Function()? phoneNumber,
    String? Function()? fullAddress,
    String? Function()? zipCode,
    String? Function()? mapUrl,
    String? Function()? latitude,
    String? Function()? longitude,
  }) {
    return Address(
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      email: email != null ? email() : this.email,
      street: street != null ? street() : this.street,
      apartment: apartment != null ? apartment() : this.apartment,
      block: block != null ? block() : this.block,
      block2: block2 != null ? block2() : this.block2,
      city: city != null ? city() : this.city,
      state: state != null ? state() : this.state,
      country: country != null ? country() : this.country,
      phoneNumber: phoneNumber != null ? phoneNumber() : this.phoneNumber,
      fullAddress: fullAddress != null ? fullAddress() : this.fullAddress,
      zipCode: zipCode != null ? zipCode() : this.zipCode,
      mapUrl: mapUrl != null ? mapUrl() : this.mapUrl,
      latitude: latitude != null ? latitude() : this.latitude,
      longitude: longitude != null ? longitude() : this.longitude,
    );
  }

  Address copyWithCountry(String? country) {
    return Address(
      firstName: firstName,
      lastName: lastName,
      email: email,
      street: null,
      apartment: null,
      block: null,
      block2: null,
      city: null,
      state: null,
      country: country,
      phoneNumber: phoneNumber,
      fullAddress: null,
      zipCode: null,
      mapUrl: null,
      latitude: null,
      longitude: null,
    );
  }
}

class ListAddress {
  List<Address> list = [];

  List<Map<String, String?>> toJsonEncodable() {
    return list.map((item) {
      return item.toJsonEncodable();
    }).toList();
  }
}
