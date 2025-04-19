import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String formatForStoreCard(DateTime date) {
    return DateFormat('dd. MMMM yyyy').format(date);
  }
}
