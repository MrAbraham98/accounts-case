import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get dateFormat => DateFormat('dd/MM/yyyy').format(this);
  String get dateFormatLongWithTime =>
      DateFormat('dd/MM/yyyy HH:mm').format(this);
  String get dateFormatWithTime => DateFormat('dd/MM HH:mm').format(this);
}
