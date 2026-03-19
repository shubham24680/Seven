import 'dart:developer';
import 'package:seven/app/app.dart';

class SportsServices {
  static SportsServices? _instance;
  SportsServices._();
  static SportsServices get instance => _instance ??= SportsServices._();

  Future<SportsModel> fetchLiveMatches({int page = 1}) async {
    final queryParams = {
      'status': '3',
      'per_paged': '50',
      'paged': '1',
      'highlight_live_matches': '1'
    };
    return _fetchMatches(
        ApiConstants.CRICKET_LIVE, queryParams, "fetchLiveMatches");
  }

  // MATCHES
  Future<SportsModel> _fetchMatches(String endPoint,
      Map<String, String> queryParams, String errorContext) async {
    try {
      final response = await BaseService.instance.fetchData(
          headerType: HeaderType.RAPID,
          apiHost: ApiConstants.CRICKET_BASE_URL,
          endPoint: endPoint,
          queryParams: queryParams);
      // debugPrint("Match response: $response");
      return SportsModel.fromJson(response);
    } on ApiException catch (e) {
      log('API Error in $errorContext: ${e.message}',
          name: 'SportsService', error: e);
      rethrow;
    } catch (e, stackTrace) {
      log('Unexpected Error in $errorContext',
          name: 'SportsService', error: e, stackTrace: stackTrace);
      throw ApiException(message: 'Failed to fetch matches', error: e);
    }
  }
}
