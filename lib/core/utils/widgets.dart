import 'package:seven/app/app.dart';

String? getImageUrl(String? endPoint) {
  if (endPoint == null) return null;

  final imageUrl = ApiConstants.IMAGE_PATH + ApiConstants.PIXEL_500 + endPoint;
  return imageUrl;
}
