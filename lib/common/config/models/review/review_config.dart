import 'package:freezed_annotation/freezed_annotation.dart';

import 'judge_service_config.dart';
import 'review_service_type.dart';

part 'review_config.freezed.dart';

part 'review_config.g.dart';

@freezed
class ReviewConfig with _$ReviewConfig {
  const factory ReviewConfig({
    @Default(ReviewServiceType.native) ReviewServiceType service,
    @Default(false) bool enableReview,
    @Default(false) bool enableReviewImage,
    @Default(JudgeServiceConfig()) JudgeServiceConfig judgeConfig,
  }) = _ReviewConfig;

  factory ReviewConfig.fromJson(Map<String, dynamic> json) =>
      _$ReviewConfigFromJson(json);
}
