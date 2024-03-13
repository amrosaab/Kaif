import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/config.dart';

part 'openai_model.freezed.dart';

part 'openai_model.g.dart';

ChatGPT get openAIConfig =>
    ChatGPT.fromJson(Map<String, dynamic>.from(kOpenAIConfig));

@freezed
class ChatGPT with _$ChatGPT {
  const factory ChatGPT({
    @Default(false) bool enableChat,
    @Default('') supabaseAnonKey,
    @Default('') supabaseUrl,
    @Default(false) bool enableSubscription,
    @Default(false) bool enableInputKey,
    @Default('') revenueAppleApiKey,
    @Default('') revenueGoogleApiKey,
    @Default([]) List<String> revenueProductsIos,
    @Default([]) List<String> revenueProductsAndroid,
  }) = _ChatGPT;

  factory ChatGPT.fromJson(Map<String, dynamic> json) =>
      _$ChatGPTFromJson(json);

  const ChatGPT._();

  Map<String, dynamic> toConfigurationJson() {
    return {
      'baseUrl': functionUrl,
      'anonKey': supabaseAnonKey,
      'enableSubscription': enableSubscription,
      'enableInputKey': enableInputKey,
      'revenueAppleApiKey': revenueAppleApiKey,
      'revenueGoogleApiKey': revenueGoogleApiKey,
      'revenueProductsIos': revenueProductsIos,
      'revenueProductsAndroid': revenueProductsAndroid,
    };
  }

  String get functionUrl => RegExp(r'(supabase\.co)|(supabase\.in)')
          .hasMatch(supabaseUrl)
      ? '${supabaseUrl.split('.')[0]}.functions.${supabaseUrl.split('.')[1]}.${supabaseUrl.split('.')[2]}'
      : '$supabaseUrl/functions/v1'
          'https://api.openai.com/v1/engines/davinci/completions';
}
