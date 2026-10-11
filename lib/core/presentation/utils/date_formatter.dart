import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String formatForStoreCard(DateTime date) {
    return DateFormat('dd. MMMM yyyy').format(date);
  }

  /// e.g. 28. September 2026
  static String formatForHistory(DateTime date) {
    return toBeginningOfSentenceCase(DateFormat('d. MMMM yyyy').format(date));
  }
}
