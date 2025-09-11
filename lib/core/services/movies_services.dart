import 'package:seven/app/app.dart';

class MoviesServices {
  Future<List<MoviesModel>> fetchData() async {
    final response = await BaseService.instance.fetchData(
      apiHost: ApiConstants.API_HOST,
      endPoint: ApiConstants.MOVIES,
      responseType: ResponseType.GET,
    );

    return response.map((json) => MoviesModel.fromJson(json)).toList();
  }
}
