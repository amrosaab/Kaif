import '../../../models/entities/review.dart';
import '../../models/entities/review_payload.dart';

extension ReviewParser on Review {
  static Review fromJudge(Map<String, dynamic> parsedJson) {
    final reviewer = parsedJson['reviewer'];
    final listImageData = List.from(parsedJson['pictures']);
    var images = <String>[];
    for (var item in listImageData) {
      if (item['hidden'] == false) {
        images.add(item['urls']['huge']);
      }
    }
    return Review(
      id: parsedJson['id'],
      title: parsedJson['title'],
      review: parsedJson['body'],
      rating: double.parse(parsedJson['rating'].toString()),
      createdAt: parsedJson['created_at'] != null
          ? DateTime.parse(parsedJson['created_at'])
          : DateTime.now(),
      name: reviewer['name'],
      email: reviewer['email'],
      // avatar: parsedJson['avatar'],
      // status: parsedJson['status'],
      // isApproved: parsedJson['is_approved'],
      images: images,
    );
  }
}

extension JudgeProductExt on String {
  // parse gid://shopify/Product/1234567890 to 1234567890
  String get numberOfProductId => split('/').last;
}

extension JudgeReviewPayloadExt on ReviewPayload {
  Map<String, dynamic> toJudgeJson() {
    return {
      'review': review,
      'rating': rating,
      'id': productId.numberOfProductId,
      'email': reviewerEmail,
      'name': reviewerName,
      'body': review,
      'shop_domain': shopDomain,
      'reviewer_name_format': '',
    };
  }
}
