import 'package:easy_localization/easy_localization.dart';
import 'package:shopengo/feature/category/domain/model/category_model.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

extension CategoryModelExtension on CategoryModel {
  /// The seeded default category is stored untranslated, so its title comes from localization.
  String get displayTitle => isDefault ? LocaleKeys.category_defaultTitle.tr() : title;
}
