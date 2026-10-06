import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _nairaFormatter = NumberFormat.currency(
    locale: 'en_NG', // Nigerian locale
    symbol: "\u{20A6}",
    decimalDigits: 2,
  );

  static final NumberFormat _nairaFormatterNoSymbol = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '',
    decimalDigits: 2,
  );

  /// Formats a number as Naira currency with the ₦ symbol
  /// Example: 1000.50 -> ₦1,000.50
  static String formatNaira(double amount) {
    return _nairaFormatter.format(amount);
  }

  /// Formats a number as Naira currency without the ₦ symbol
  /// Example: 1000.50 -> 1,000.50
  static String formatAmount(double amount) {
    return _nairaFormatterNoSymbol.format(amount).trim();
  }

  /// Formats a number as Naira currency with custom symbol placement
  /// Example: 1000.50 -> "₦ 1,000.50" (with space)
  static String formatNairaWithSpace(double amount) {
    return '"\u{20A6}" ${formatAmount(amount)}';
  }

  /// Formats a number with Nigerian locale formatting (commas) but no currency symbol
  /// Example: 1000.50 -> "1,000.50"
  static String formatNumber(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_NG');
    return formatter.format(amount);
  }
}
