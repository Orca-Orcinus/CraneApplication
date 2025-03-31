import 'package:intl/intl.dart';

String numberToWords(int number) {
  final format = NumberFormat('#######', 'en_US');
  return format.format(number);
}