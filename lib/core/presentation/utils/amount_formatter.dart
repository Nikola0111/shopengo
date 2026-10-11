import 'package:easy_localization/easy_localization.dart';

class AmountFormatter {
  /// Groups thousands and shows decimals only when there are any, e.g. 5.450 or 1.299,5 in Serbian.
  static String format(double amount) {
    return NumberFormat('#,##0.##').format(amount);
  }
}
