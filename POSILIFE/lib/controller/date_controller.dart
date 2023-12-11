import 'package:intl/intl.dart';


String formatDateOnly(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date); // Or any other format you prefer
}

