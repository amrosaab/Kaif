import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'judge_service_config.freezed.dart';

part 'judge_service_config.g.dart';

@freezed
class JudgeServiceConfig with _$JudgeServiceConfig {
  const factory JudgeServiceConfig({
    @Default('') String domain,
    @Default('') String apiKey,
  }) = _JudgeServiceConfig;

  factory JudgeServiceConfig.fromJson(Map<String, dynamic> json) =>
      _$JudgeServiceConfigFromJson(json);
}
