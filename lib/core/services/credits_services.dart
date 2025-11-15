import 'dart:developer';
import 'package:seven/app/app.dart';

class CreditsServices {
  static CreditsServices? _instance;
  CreditsServices._();
  static CreditsServices get instance => _instance ??= CreditsServices._();

  Future<Credits> fetchCasts(String id) async => _fetchCredits(
      ApiConstants.MOVIE_DETAIL + id + ApiConstants.CREDITS, "fetchCasts");

  // RESULT
  Future<Credits> _fetchCredits(String endPoint, String errorContext) async {
    try {
      final response = await BaseService.instance.fetchData(
          apiHost: ApiConstants.BASE_URL,
          endPoint: endPoint,
          responseType: ResponseType.GET);

      return Credits.fromJson(response);
    } on ApiException catch (e) {
      log('API Error in $errorContext: ${e.message}',
          name: 'CreditsService', error: e);
      rethrow;
    } catch (e, stackTrace) {
      log('Unexpected Error in $errorContext',
          name: 'CreditsService', error: e, stackTrace: stackTrace);
      throw ApiException(message: 'Failed to fetch credits', error: e);
    }
  }
}
