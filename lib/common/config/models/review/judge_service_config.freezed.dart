// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'judge_service_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JudgeServiceConfig _$JudgeServiceConfigFromJson(Map<String, dynamic> json) {
  return _JudgeServiceConfig.fromJson(json);
}

/// @nodoc
mixin _$JudgeServiceConfig {
  String get domain => throw _privateConstructorUsedError;
  String get apiKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JudgeServiceConfigCopyWith<JudgeServiceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JudgeServiceConfigCopyWith<$Res> {
  factory $JudgeServiceConfigCopyWith(
          JudgeServiceConfig value, $Res Function(JudgeServiceConfig) then) =
      _$JudgeServiceConfigCopyWithImpl<$Res, JudgeServiceConfig>;
  @useResult
  $Res call({String domain, String apiKey});
}

/// @nodoc
class _$JudgeServiceConfigCopyWithImpl<$Res, $Val extends JudgeServiceConfig>
    implements $JudgeServiceConfigCopyWith<$Res> {
  _$JudgeServiceConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? apiKey = null,
  }) {
    return _then(_value.copyWith(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JudgeServiceConfigCopyWith<$Res>
    implements $JudgeServiceConfigCopyWith<$Res> {
  factory _$$_JudgeServiceConfigCopyWith(_$_JudgeServiceConfig value,
          $Res Function(_$_JudgeServiceConfig) then) =
      __$$_JudgeServiceConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String domain, String apiKey});
}

/// @nodoc
class __$$_JudgeServiceConfigCopyWithImpl<$Res>
    extends _$JudgeServiceConfigCopyWithImpl<$Res, _$_JudgeServiceConfig>
    implements _$$_JudgeServiceConfigCopyWith<$Res> {
  __$$_JudgeServiceConfigCopyWithImpl(
      _$_JudgeServiceConfig _value, $Res Function(_$_JudgeServiceConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? apiKey = null,
  }) {
    return _then(_$_JudgeServiceConfig(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JudgeServiceConfig
    with DiagnosticableTreeMixin
    implements _JudgeServiceConfig {
  const _$_JudgeServiceConfig({this.domain = '', this.apiKey = ''});

  factory _$_JudgeServiceConfig.fromJson(Map<String, dynamic> json) =>
      _$$_JudgeServiceConfigFromJson(json);

  @override
  @JsonKey()
  final String domain;
  @override
  @JsonKey()
  final String apiKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'JudgeServiceConfig(domain: $domain, apiKey: $apiKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'JudgeServiceConfig'))
      ..add(DiagnosticsProperty('domain', domain))
      ..add(DiagnosticsProperty('apiKey', apiKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JudgeServiceConfig &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, domain, apiKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JudgeServiceConfigCopyWith<_$_JudgeServiceConfig> get copyWith =>
      __$$_JudgeServiceConfigCopyWithImpl<_$_JudgeServiceConfig>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JudgeServiceConfigToJson(
      this,
    );
  }
}

abstract class _JudgeServiceConfig implements JudgeServiceConfig {
  const factory _JudgeServiceConfig(
      {final String domain, final String apiKey}) = _$_JudgeServiceConfig;

  factory _JudgeServiceConfig.fromJson(Map<String, dynamic> json) =
      _$_JudgeServiceConfig.fromJson;

  @override
  String get domain;
  @override
  String get apiKey;
  @override
  @JsonKey(ignore: true)
  _$$_JudgeServiceConfigCopyWith<_$_JudgeServiceConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
