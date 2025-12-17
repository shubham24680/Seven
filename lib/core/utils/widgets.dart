import 'package:intl/intl.dart';
import 'package:seven/app/app.dart';

String? getRuntime(int? runtime) {
  if (runtime == null || runtime <= 0) return null;
  final hours = runtime ~/ 60;
  final minutes = runtime % 60;
  return [if (hours > 0) "$hours h", if (minutes > 0) "$minutes min"].join(" ");
}

// DATE
enum FormatType { YMMMD, Y, DATE }

dynamic getDateFormat(dynamic date, {FormatType formatType = FormatType.Y}) {
  if (date == null) return null;

  DateFormat dateFormat;
  switch (formatType) {
    case FormatType.DATE:
      dateFormat = DateFormat('yyyy-MM-dd');
    case FormatType.YMMMD:
      dateFormat = DateFormat.yMMMd();
    default:
      dateFormat = DateFormat.y();
  }

  if (date == String) return dateFormat.parse(date);
  return dateFormat.format(date);
}

// CURRENCY
String? getCurrencyFormat(int? currency, String? locale) {
  if (currency == null || currency <= 0) return null;

  return NumberFormat.currency(locale: "en_US", symbol: "\$ ", decimalDigits: 0)
      .format(currency);
}

Color parseColor(String? baseColor,
    {Color defaultColor = AppColors.lightSteel1}) {
  String color = baseColor ?? "";
  switch (color.length) {
    case 9:
      color = color.replaceFirst("#", "0x");
      break;
    case 7:
      color = color.replaceFirst("#", "0xFF");
      break;
    default:
      return defaultColor;
  }

  return Color(int.parse(color));
}
