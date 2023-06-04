import 'package:intl/intl.dart';

extension MyDate on DateTime {
  String formatDate() {
    final DateFormat formatter = DateFormat("dd MMMM yyyy, HH:mm");
    return formatter.format(this);
  }
}
