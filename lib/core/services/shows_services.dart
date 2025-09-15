import 'dart:developer';

import 'package:seven/app/app.dart';

class ShowsServices {
  static ShowsServices? _instance;
  ShowsServices._();
  static ShowsServices get instance => _instance ??= ShowsServices._();

  Future<ShowsModel> fetchShows() async {
    try {
      final response = await BaseService.instance.fetchData(
        apiHost: ApiConstants.API_HOST,
        endPoint: ApiConstants.MOVIES,
        responseType: ResponseType.GET,
      );

      return response != null ? ShowsModel.fromJson(response) : ShowsModel();
    } on ApiException {
      rethrow;
    } catch (e) {
      log("Unexpected error while fetching shows: $e");
      throw ApiException(
          statusCode: 1, message: "Unexpected error while fetching shows: $e");
    }
  }
}
