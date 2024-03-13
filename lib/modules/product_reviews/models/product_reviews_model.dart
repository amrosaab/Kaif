import 'package:flutter/material.dart';
import '../../../models/entities/index.dart';
import '../../../models/entities/paging_response.dart';
import '../../../models/paging_data_model.dart';

class ProductReviewsModel extends PagingDataModel<Review> {
  final Product _product;

  double? get averageRating => _product.averageRating;

  int? get ratingCount => _product.ratingCount;

  ProductReviewsModel(this._product) {
    getData();
  }

  @override
  dynamic get initCursorValue => 1;

  @protected
  @override
  Future<PagingResponse<Review>> Function(dynamic page) get requestApi =>
      (page) => api.getReviews(_product.id, page: page);
}
