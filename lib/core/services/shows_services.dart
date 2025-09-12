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

      if (response == null) {
        throw ApiException(statusCode: 0, message: "No data");
      }

      return ShowsModel.fromJson(response);
    } on ApiException {
      rethrow;
    } catch (e) {
      log("Unexpected error while fetching shows: $e");
      throw ApiException(
          statusCode: 1, message: "Unexpected error while fetching shows: $e");
    }
  }
}
