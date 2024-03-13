class MyBrandModel {
  MyBrandModel({this.title});
  late String? title;

  factory MyBrandModel.fromShopifyJson(String json) {
    return MyBrandModel(title: json);
  }
}
