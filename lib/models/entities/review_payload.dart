class ReviewPayload {
  final String review;
  final int rating;
  final String productId;
  final String? reviewerEmail;
  final String reviewerName;
  final String? reviewerId;
  final String? shopDomain;
  final String? token;
  final String? status;
  final String? image;

  const ReviewPayload({
    required this.review,
    required this.rating,
    required this.productId,
    required this.reviewerName,
    this.reviewerId,
    this.reviewerEmail,
    this.shopDomain,
    this.token,
    this.status,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating': rating,
      'product_id': productId,
      'email': reviewerEmail,
      'name': reviewerName,
      'shop_domain': shopDomain,
      'token': token,
    };
  }

  Map<String, dynamic> toShopifyJson() {
    return {
      'review': review,
      'rating': rating,
      'product_id': productId,
      'email': reviewerEmail,
      'shop_domain': shopDomain,
      'platform': 'shopify',
      'body': review,
      'id': productId,
      'name': 'John Smith',
      'reviewer_name_format': '',
      'title': 'Review from Mobile app',
    };
  }

  Map<String, dynamic> toWooJson() {
    return {
      'review': review,
      'reviewer': reviewerName,
      'reviewer_email': reviewerEmail,
      'rating': rating,
      'status': status,
      'product_id': productId,
    };
  }

  Map<String, dynamic> toListProJson() {
    return {
      'listing_id': productId,
      'post_content': review,
      'post_author': reviewerId,
      'post_title': review,
      'rating': rating.toString(),
    };
  }

  Map<String, String> toListeoJson() {
    final ratingString = rating.toString();
    return {
      'comment_post_ID': productId,
      'comment': review,
      'submit': 'Post Comment',
      'comment_parent': '0',
      'value-for-money': ratingString,
      'service': ratingString,
      'location': ratingString,
      'cleanliness': ratingString,
      'email': reviewerEmail ?? '',
      'author': reviewerName,
    };
  }

  Map<String, String> toListingJson() {
    final ratingString = (rating * 2).toString();
    return {
      'comment_post_ID': productId,
      'comment': review,
      'submit': 'Post Comment',
      'comment_parent': '0',
      'rating_star_rating': ratingString,
      'hospitality_star_rating': ratingString,
      'service_star_rating': ratingString,
      'pricing_star_rating': ratingString,
      'email': reviewerEmail ?? '',
      'author': reviewerName,
    };
  }
}
