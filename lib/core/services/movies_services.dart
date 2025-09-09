import 'package:seven/app/app.dart';

class MoviesServices {
  final BaseService _services = BaseService();

  // List<MoviesModel> fetchData() {
  //   final response = _services.fetchData(
  //       apiHost: ApiConstants.API_HOST,
  //       endPoint: ApiConstants.MOVIES,
  //       responseType: ResponseType.GET);

  //   return response.map<MoviesModel>((json) => MoviesModel.fromJson(json)).toList();
  // }
}
