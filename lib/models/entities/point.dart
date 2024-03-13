class Point {
  int? points;
  double? cartPriceRate;
  int? cartPointsRate;
  String? maxPointDiscount; //  Variables `max_point_discount` and `max_product_point_discount` can be strings. E.g. '5%'
  String? maxProductPointDiscount; 

  Point.fromJson(Map parsedJson) {
    points = parsedJson['points'];
    cartPriceRate = parsedJson['cart_price_rate'].toDouble();
    cartPointsRate = int.tryParse('${parsedJson['cart_points_rate']}');
    maxPointDiscount = parsedJson['max_point_discount'];
    maxProductPointDiscount = parsedJson['max_product_point_discount'];
  }
}
