import 'package:easy_localization/easy_localization.dart';
import 'package:shopengo/feature/product/domain/model/amount_type.dart';
import 'package:shopengo/generated/locale_keys.g.dart';

extension AmountTypeExtension on AmountType {
  String get shortLabel => switch (this) {
    AmountType.piece => LocaleKeys.amountType_piece.tr(),
    AmountType.pack => LocaleKeys.amountType_pack.tr(),
    AmountType.gram => LocaleKeys.amountType_gram.tr(),
    AmountType.kilogram => LocaleKeys.amountType_kilogram.tr(),
    AmountType.liter => LocaleKeys.amountType_liter.tr(),
  };
}
