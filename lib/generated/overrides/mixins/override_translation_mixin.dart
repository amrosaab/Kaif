import '../../l10n.dart';

mixin OverrideTranslateActionMixin {
  S get parent;
  Map? get customLanguage;
  String getCustomTranslate(String key, String defauldValue, {Map? args});
}