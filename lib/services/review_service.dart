import '../models/entities/paging_response.dart';
import '../models/entities/rating_count.dart';
import '../models/entities/review.dart';
import '../models/entities/review_payload.dart';

abstract class ReviewService {
  const factory ReviewService.base() = _ReviewServiceImpl;

  const ReviewService();

  Future<PagingResponse<Review>> getReviews(
    String productId, {
    int page = 1,
    int perPage = 20,
  });

  Future<void> createReview(ReviewPayload payload);

  Future<RatingCount?> getProductRatingCount(String productId);
}

class _ReviewServiceImpl implements ReviewService {
  const _ReviewServiceImpl();

  @override
  Future<void> createReview(ReviewPayload payload) async {
    return;
  }

  @override
  Future<PagingResponse<Review>> getReviews(String productId,
      {int page = 1, int perPage = 20}) async {
    return const PagingResponse();
  }

  @override
  Future<RatingCount?> getProductRatingCount(String productId) async {
    return null;
  }
}
