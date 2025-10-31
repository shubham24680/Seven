import 'dart:developer';
import 'package:seven/app/app.dart';

class ShowsServices {
  static ShowsServices? _instance;
  ShowsServices._();
  static ShowsServices get instance => _instance ??= ShowsServices._();

  Future<ShowsModel?> search(String query) async {
    try {
      final response = await BaseService.instance.fetchData(
          apiHost: ApiConstants.BASE_URL,
          endPoint: ApiConstants.SEARCH,
          responseType: ResponseType.GET,
          queryParams: {"query": query});

      return response != null ? ShowsModel.fromJson(response) : null;
    } catch (e) {
      log("Internal Error -> $e");
      return null;
    }
  }

  Future<ShowsModel> fetchTrendingShows({int page = 1}) async =>
      _fetchShows(ApiConstants.TRENDING_MOVIES, page, "fetchTrendingShows");

  Future<ShowsModel> fetchTopShows({int page = 1}) async =>
      _fetchShows(ApiConstants.TOP_RATED, page, "fetchTopShows");

  Future<ShowsModel> fetchNewReleaseShows({int page = 1}) async =>
      _fetchShows(ApiConstants.NOW_PLAYING, page, "fetchNewReleaseShows");

  Future<ShowsModel> fetchUpcomingShows({int page = 1}) async =>
      _fetchShows(ApiConstants.UPCOMING, page, "fetchUpcomingShows");

  // Remove this and use _fetchShows.
  Future<List<ShowsModel?>?> fetchCollections() async {
    try {
      final response = await Future.wait(ApiConstants.COLLECTIONS
          .map((endPoint) => BaseService.instance.fetchData(
                apiHost: ApiConstants.BASE_URL,
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

  Future<Result> fetchGenres() async =>
      _fetchResult(ApiConstants.GENRES, "fetchGenres");

  Future<Result> fetchShowDetail(String id) async =>
      _fetchResult(ApiConstants.MOVIE_DETAIL + id, "fetchShowDetail");

  Future<Result> fetchCollectionDetail(String id) async => _fetchResult(
      ApiConstants.COLLECTION_DETAIL + id, "fetchCollectionDetail");

  // SHOW
  Future<ShowsModel> _fetchShows(
      String endPoint, int page, String errorContext) async {
    try {
      final response = await BaseService.instance.fetchData(
          apiHost: ApiConstants.BASE_URL,
          endPoint: endPoint,
          responseType: ResponseType.GET,
          queryParams: {
            'page': page.toString(),
            'language': ApiConstants.DEFAULT_LANGUAGE
          });

      return ShowsModel.fromJson(response);
    } on ApiException catch (e) {
      log('API Error in $errorContext: ${e.message}',
          name: 'ShowsService', error: e);
      rethrow;
    } catch (e, stackTrace) {
      log('Unexpected Error in $errorContext',
          name: 'ShowsService', error: e, stackTrace: stackTrace);
      throw ApiException(message: 'Failed to fetch shows', error: e);
    }
  }

// RESULT
  Future<Result> _fetchResult(String endPoint, String errorContext) async {
    try {
      final response = await BaseService.instance.fetchData(
          apiHost: ApiConstants.BASE_URL,
          endPoint: endPoint,
          responseType: ResponseType.GET,
          queryParams: {'language': ApiConstants.DEFAULT_LANGUAGE});

      return Result.fromJson(response);
    } on ApiException catch (e) {
      log('API Error in $errorContext: ${e.message}',
          name: 'ShowsService', error: e);
      rethrow;
    } catch (e, stackTrace) {
      log('Unexpected Error in $errorContext',
          name: 'ShowsService', error: e, stackTrace: stackTrace);
      throw ApiException(message: 'Failed to fetch result', error: e);
    }
  }
}
