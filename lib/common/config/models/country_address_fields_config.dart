import 'address_field_config.dart';

class CountryAddressFieldsConfig {
  CountryAddressFieldsConfig({
    required this.country,
    required this.addressFields,
  });

  final String country;
  final List<AddressFieldConfig> addressFields;

  factory CountryAddressFieldsConfig.fromJson(Map<String, dynamic> json) {
    final country = json['country'];

    final addressFields = (json['addressFields'] as List)
    .fold(<AddressFieldConfig>[], (acc, e) {
      final field = AddressFieldConfig.fromMap(e);
      if (field.type != AddressFieldType.unknown) {
        acc.add(field);
      }
      return acc;
    });

    addressFields.sort((a, b) => a.position.compareTo(b.position));

    return CountryAddressFieldsConfig(
      country: country,
      addressFields: addressFields,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
    data['addressFields'] = addressFields.map((e) => e.toMap()).toList();
    return data;
  }

  CountryAddressFieldsConfig copyWith({
    String? country,
    List<AddressFieldConfig>? addressFields,
  }) {
    return CountryAddressFieldsConfig(
      country: country ?? this.country,
      addressFields: addressFields ?? this.addressFields,
    );
  }
}