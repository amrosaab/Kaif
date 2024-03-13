class Tax {
  String? id;
  String? title;
  double? amount;

  Tax.fromJson(Map parsedJson) {
    title = parsedJson['label'];
    amount = double.parse('${(parsedJson['value'] ?? 0.0)}');
  }

  Tax.fromMagentoJson(Map parsedJson) {
    title = parsedJson['title'];
    amount = double.parse('${(parsedJson['value'] ?? 0.0)}');
  }
}

class CartTax {
  const CartTax({this.items, this.total, this.isIncludingTax});

  final List<Tax>? items;
  final double? total;
  final bool? isIncludingTax;
}
