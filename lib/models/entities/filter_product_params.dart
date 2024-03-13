import '../../services/service_config.dart';

class FilterProductParams {
  final String? attribute;
  final String? attributeTerm;
  final String? brand;

  FilterProductParams({this.attribute, this.attributeTerm, this.brand});

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    final serverConfig = ServerConfig();

    if (serverConfig.isWooType) {
      result.addAll({'attribute': attribute});
      result.addAll({'attribute_term': attributeTerm});
      result.addAll({'brand': brand});

      result.removeWhere((key, value) => value == null || value.isEmpty);

      return result;
    }
    return {};
  }

  factory FilterProductParams.fromJson(Map<String, dynamic> json) {
    String? attribute;
    String? attributeTerm;
    String? brand;
    final serverConfig = ServerConfig();

    if (serverConfig.isWooType) {
      attribute = json['attribute'];
      attributeTerm = json['attribute_term'];
      brand = json['brand'];
    }

    return FilterProductParams(
      attribute: attribute,
      attributeTerm: attributeTerm,
      brand: brand,
    );
  }
}
