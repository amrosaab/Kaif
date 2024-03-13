import '../../../common/config.dart';
import '../../../common/config/models/index.dart';
import '../../../modules/judge_me/judge_review_service.dart';
import '../../../services/service_config.dart';
import '../index.dart';
import 'shopify_service.dart';

mixin ShopifyMixin on ConfigMixin {
  @override
  void configShopify(appConfig) {
    final reviewService = switch (kReviewConfig.service) {
      ReviewServiceType.native => null,
      ReviewServiceType.judge =>
        JudgeReviewService(apiKey: kReviewConfig.judgeConfig.apiKey),
    };

    final shopifyService = ShopifyService(
      domain: appConfig['url'],
      blogDomain: appConfig['blog'],
      accessToken: appConfig['accessToken'],
      reviewService: reviewService,
    );
    api = shopifyService;
    widget = ShopifyWidget(shopifyService);
  }
}
