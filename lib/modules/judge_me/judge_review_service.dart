import 'package:dio/dio.dart';
import 'package:inspireui/utils/logs.dart';

import '../../models/entities/paging_response.dart';
import '../../models/entities/rating_count.dart';
import '../../models/entities/review.dart';
import '../../models/entities/review_payload.dart';
import '../../services/review_service.dart';
import 'judge_extension.dart';

const _domain = 'https://judge.me/api/v1';

class _JudgeEndpoints {
  static const String reviews = '/reviews';
  static const String productRatingCount = '/reviews/count';
  static const String product = '/products/-1';
}

class JudgeReviewService extends ReviewService {
  JudgeReviewService({
    required this.apiKey,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: _domain,
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({
            'api_token': apiKey,
          });
          return handler.next(options);
        },
      ),
    );
  }

  final String apiKey;
  final Dio _dio;

  @override
  Future<void> createReview(ReviewPayload payload) async {
    try {
      await _dio.post(
        _JudgeEndpoints.reviews,
        data: payload.toJudgeJson(),
      );
    } catch (e) {
      printLog(e);
      throw 'Failed to create review';
    }
    return;
  }

  @override
  Future<PagingResponse<Review>> getReviews(
    String productId, {
    int page = 1,
    int perPage = 20,
  }) async {
    final internalProductId = await _getJudgeProductId(
      externalProductId: productId,
    );
    if (internalProductId == null) {
      return const PagingResponse();
    }

    printLog('[JudgeReview] getReviews $internalProductId');

    final response = await _dio.get(_JudgeEndpoints.reviews, queryParameters: {
      'product_id': internalProductId,
      'page': page,
      'per_page': perPage,
    });
    final data = response.data;
    if (data is Map) {
      final reviews = data['reviews'];
      if (reviews is List) {
        return PagingResponse(
          data: reviews
              .where((element) => element['hidden'] == false)
              .map((e) => ReviewParser.fromJudge(e))
              .toList(),
        );
      }
    }
    return const PagingResponse();
  }

  Future<String?> _getJudgeProductId(
      {required String externalProductId}) async {
    final response = await _dio.get(_JudgeEndpoints.product, queryParameters: {
      'external_id': externalProductId.numberOfProductId,
    });

    final data = response.data;
    if (data is Map) {
      final productId = data['product']['id'];
      if (productId is int) {
        return productId.toString();
      }
    }
    return null;
  }

  @override
  Future<RatingCount?> getProductRatingCount(String productId) async {
    final internalProductId = await _getJudgeProductId(
      externalProductId: productId,
    );
    if (internalProductId == null) {
      return null;
    }

    final ratingCount = await Future.wait([
      _getRatingCountOfProduct(internalProductId, 1),
      _getRatingCountOfProduct(internalProductId, 2),
      _getRatingCountOfProduct(internalProductId, 3),
      _getRatingCountOfProduct(internalProductId, 4),
      _getRatingCountOfProduct(internalProductId, 5),
    ]);
    return RatingCount(
      oneStar: ratingCount[0],
      twoStar: ratingCount[1],
      threeStar: ratingCount[2],
      fourStar: ratingCount[3],
      fiveStar: ratingCount[4],
    );
  }

  Future<int> _getRatingCountOfProduct(
    String internalProductId,
    int rating,
  ) async {
    final response =
        await _dio.get(_JudgeEndpoints.productRatingCount, queryParameters: {
      'product_id': internalProductId,
      'rating': rating,
    });
    final data = response.data;
    if (data is Map) {
      final count = data['count'];
      if (count is int) {
        return count;
      }
    }
    return 0;
  }
}
