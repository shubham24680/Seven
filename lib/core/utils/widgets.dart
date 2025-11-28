import 'package:intl/intl.dart';
import 'package:seven/app/app.dart';

// IMAGE
String? getImageUrl(String? endPoint) {
  if (endPoint == null || endPoint.isEmpty) return null;

  final imageUrl = ApiConstants.IMAGE_PATH + ApiConstants.PIXEL_500 + endPoint;
  return imageUrl;
}

// RUNTIME
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
