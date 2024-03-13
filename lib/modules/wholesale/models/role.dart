class WholesaleRole {
  const WholesaleRole({this.key, this.name, this.desc});

  final String? key;
  final String? name;
  final String? desc;

  factory WholesaleRole.fromJson(Map parsedJson) => WholesaleRole(
      name: parsedJson['roleName'],
      key: parsedJson['key'],
      desc: parsedJson['desc']);
}
