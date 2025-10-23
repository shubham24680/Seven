import 'dart:developer';

import 'package:seven/app/app.dart';

class ShowsServices {
  static ShowsServices? _instance;
  ShowsServices._();
  static ShowsServices get instance => _instance ??= ShowsServices._();

  Future<ShowsModel?> fetchShows() async {
    try {
      final response = await BaseService.instance.fetchData(
        apiHost: ApiConstants.API_HOST,
        endPoint: ApiConstants.TRENDING_MOVIES,
        responseType: ResponseType.GET,
      );

      return response != null ? ShowsModel.fromJson(response) : null;
    } catch (e) {
      log("Internal Error -> $e");
      return null;
    }
  }

  Future<GenreModel?> fetchGenres() async {
    try {
      final response = await BaseService.instance.fetchData(
        apiHost: ApiConstants.API_HOST,
        endPoint: ApiConstants.GENRES,
        responseType: ResponseType.GET,
      );

      return response != null ? GenreModel.fromJson(response) : null;
    } catch (e) {
      log("Internal Error -> $e");
      return null;
    }
  }

  Future<List<ShowsModel?>?> fetchCollections() async {
    try {
      final response = await Future.wait(ApiConstants.COLLECTIONS
          .map((endPoint) => BaseService.instance.fetchData(
                apiHost: ApiConstants.API_HOST,
                endPoint: endPoint,
                responseType: ResponseType.GET,
              ))
          .toList());

      return response.map((json) {
        log("Collection -> ${json == null ? null : "Success"}");
        return (json != null) ? ShowsModel.fromJson(json) : null;
      }).toList();
    } catch (e) {
      log("Internal Error -> $e");
      return null;
    }
  }
}
