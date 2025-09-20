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

  Future<GenreModel> fetchGenres() async {
    try {
      final response = await BaseService.instance.fetchData(
        apiHost: ApiConstants.API_HOST,
        endPoint: ApiConstants.GENRES,
        responseType: ResponseType.GET,
      );

      return response != null ? GenreModel.fromJson(response) : GenreModel();
    } on ApiException {
      rethrow;
    } catch (e) {
      log("Unexpected error while fetching shows: $e");
      throw ApiException(
          statusCode: 1, message: "Unexpected error while fetching shows: $e");
    }
  }

  // Future<ShowsModel> fetchNowPlaying() async {
  //   try {
  //     final response = await BaseService.instance.fetchData(
  //       apiHost: ApiConstants.API_HOST,
  //       endPoint: ApiConstants.NOW_PLAYING,
  //       responseType: ResponseType.GET,
  //     );

  //     return response != null ? ShowsModel.fromJson(response) : ShowsModel();
  //   } on ApiException {
  //     rethrow;
  //   } catch (e) {
  //     log("Unexpected error while fetching now playing: $e");
  //     throw ApiException(
  //         statusCode: 1,
  //         message: "Unexpected error while fetching now playing: $e");
  //   }
  // }

  // Future<ShowsModel> fetchPopular() async {
  //   try {
  //     final response = await BaseService.instance.fetchData(
  //       apiHost: ApiConstants.API_HOST,
  //       endPoint: ApiConstants.POPULAR,
  //       responseType: ResponseType.GET,
  //     );

  //     return response != null ? ShowsModel.fromJson(response) : ShowsModel();
  //   } on ApiException {
  //     rethrow;
  //   } catch (e) {
  //     log("Unexpected error while fetching popular: $e");
  //     throw ApiException(
  //         statusCode: 1,
  //         message: "Unexpected error while fetching popular: $e");
  //   }
  // }

  // Future<ShowsModel> fetchTopRated() async {
  //   try {
  //     final response = await BaseService.instance.fetchData(
  //       apiHost: ApiConstants.API_HOST,
  //       endPoint: ApiConstants.TOP_RATED,
  //       responseType: ResponseType.GET,
  //     );

  //     return response != null ? ShowsModel.fromJson(response) : ShowsModel();
  //   } on ApiException {
  //     rethrow;
  //   } catch (e) {
  //     log("Unexpected error while fetching top rated: $e");
  //     throw ApiException(
  //         statusCode: 1,
  //         message: "Unexpected error while fetching top rated: $e");
  //   }
  // }

  // Future<ShowsModel> fetchUpcoming() async {
  //   try {
  //     final response = await BaseService.instance.fetchData(
  //       apiHost: ApiConstants.API_HOST,
  //       endPoint: ApiConstants.UPCOMING,
  //       responseType: ResponseType.GET,
  //     );

  //     return response != null ? ShowsModel.fromJson(response) : ShowsModel();
  //   } on ApiException {
  //     rethrow;
  //   } catch (e) {
  //     log("Unexpected error while fetching upcoming: $e");
  //     throw ApiException(
  //         statusCode: 1,
  //         message: "Unexpected error while fetching upcoming: $e");
  //   }
  // }
}
