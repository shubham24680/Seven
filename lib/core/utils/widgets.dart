import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:seven/app/app.dart';

String? getImageUrl(String? endPoint) {
  if (endPoint == null) return null;

  final imageUrl = ApiConstants.IMAGE_PATH + ApiConstants.PIXEL_500 + endPoint;
  return imageUrl;
}

String? getRuntime(int? runtime) {
  if (runtime == null || runtime <= 0) return null;
  final hours = runtime ~/ 60;
  final minutes = runtime % 60;
  return "$hours h $minutes min";
}

enum FormatType { DATE, YEAR }

dynamic getDateFormat(dynamic date, {FormatType type = FormatType.YEAR}) {
  if (date == null) return null;

  DateFormat dateFormat;
  switch (type) {
    case FormatType.DATE:
      dateFormat = DateFormat.yMMMd();
    default:
      dateFormat = DateFormat.y();
  }

  if (date == String) return dateFormat.parse(date);
  return dateFormat.format(date);
}

String? getCurrencyFormat(int? currency, String? locale) {
  log("Currency -> $currency");
  if (currency == null || currency <= 0) return null;

  return NumberFormat.currency(locale: "en_US", symbol: "\$ ", decimalDigits: 0)
      .format(currency);
}
