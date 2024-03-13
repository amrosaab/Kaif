// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReviewConfig _$$_ReviewConfigFromJson(Map<String, dynamic> json) =>
    _$_ReviewConfig(
      service:
          $enumDecodeNullable(_$ReviewServiceTypeEnumMap, json['service']) ??
              ReviewServiceType.native,
      enableReview: json['enableReview'] as bool? ?? false,
      enableReviewImage: json['enableReviewImage'] as bool? ?? false,
      judgeConfig: json['judgeConfig'] == null
          ? const JudgeServiceConfig()
          : JudgeServiceConfig.fromJson(
              json['judgeConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ReviewConfigToJson(_$_ReviewConfig instance) =>
    <String, dynamic>{
      'service': _$ReviewServiceTypeEnumMap[instance.service]!,
      'enableReview': instance.enableReview,
      'enableReviewImage': instance.enableReviewImage,
      'judgeConfig': instance.judgeConfig.toJson(),
    };

const _$ReviewServiceTypeEnumMap = {
  ReviewServiceType.native: 'native',
  ReviewServiceType.judge: 'judge',
};
