import 'package:intl/intl.dart';

class CustomFormatter {
  static final currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0
  );

  static final dateFormatter = DateFormat.yMMMMEEEEd();
}