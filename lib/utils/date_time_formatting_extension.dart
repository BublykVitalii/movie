import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String yMMMMd(String locale) {
    return DateFormat.yMMMMd(locale).format(this);
  }
}
