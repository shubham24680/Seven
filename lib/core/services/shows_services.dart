import 'dart:developer';
import 'package:seven/app/app.dart';

final now = DateTime.now();

class ShowsServices {
  static ShowsServices? _instance;
  ShowsServices._();
  static ShowsServices get instance => _instance ??= ShowsServices._();

  Future<ShowsModel> searchWithTitle({int page = 1, String title = ""}) async {
    final queryParams = {
      'page': page.toString(),
      if (title.isNotEmpty) 'query': title
    };
    return _fetchShows(ApiConstants.SEARCH, queryParams, "searchWithTitle");
  }

  Future<ShowsModel> fetchTrendingShows({int page = 1}) async {
    final queryParams = {'page': page.toString()};
    return _fetchShows(
        ApiConstants.TRENDING_MOVIES, queryParams, "fetchTrendingShows");
  }

  Future<ShowsModel> fetchTopShows({int page = 1}) async {
    final queryParams = {
      'page': page.toString(),
      'sort_by': SortBy.VOTE_AVERAGE_DESC,
      'vote_count.gte': "200"
    };
    return _fetchShows(ApiConstants.MOVIES, queryParams, "fetchTopShows");
  }

  Future<ShowsModel> fetchNewReleaseShows({int page = 1}) async {
    final minDate = getDateFormat(DateTime(now.year - 1, now.month, now.day),
            formatType: FormatType.DATE)
        .toString();
    final maxDate = getDateFormat(now, formatType: FormatType.DATE).toString();
    final queryParams = {
      'page': page.toString(),
      'sort_by': SortBy.POPULARITY_DESC,
      'primary_release_date.gte': minDate,
      'primary_release_date.lte': maxDate
    };
    return _fetchShows(
        ApiConstants.MOVIES, queryParams, "fetchNewReleaseShows");
  }

  Future<ShowsModel> fetchUpcomingShows({int page = 1}) async {
    final maxDate = getDateFormat(DateTime(now.year, now.month, now.day + 1),
            formatType: FormatType.DATE)
        .toString();
    final queryParams = {
      'page': page.toString(),
      'sort_by': SortBy.PRIMARY_RELEASE_DATE_ASC,
      'primary_release_date.gte': maxDate
    };
    return _fetchShows(ApiConstants.MOVIES, queryParams, "fetchUpcomingShows");
  }

  Future<Result> fetchGenres() async =>
      _fetchResult(ApiConstants.GENRES, "fetchGenres");

  Future<Result> fetchShowDetail(String id) async =>
      _fetchResult(ApiConstants.MOVIE_DETAIL + id, "fetchShowDetail");

  Future<Result> fetchCollectionDetail(String id) async => _fetchResult(
      ApiConstants.COLLECTION_DETAIL + id, "fetchCollectionDetail");

  // SHOW
  Future<ShowsModel> _fetchShows(String endPoint,
      Map<String, String> queryParams, String errorContext) async {
    try {
      final response = await BaseService.instance.fetchData(
          apiHost: ApiConstants.BASE_URL,
          endPoint: endPoint,
          responseType: ResponseType.GET,
          queryParams: queryParams);

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
