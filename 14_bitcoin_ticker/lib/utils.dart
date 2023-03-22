import 'package:intl/intl.dart';

String numberFormatter(double n) {
  NumberFormat f1 = NumberFormat("##0.00", "en_US");
  NumberFormat f2 = NumberFormat.compact();

  String s = f1.format(n);
  if (n < 1000) {
    return s;
  }
  return f2.format(double.tryParse(s));
}
