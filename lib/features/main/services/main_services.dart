import '../../../app/app.dart';

class MainServices {
  MainServices._();

  static MainServices? _instance;
  static MainServices get instance => _instance ??= MainServices._();

  Future<MainModel> fetchMainScreenData() async {
    final response = await BaseService.instance.fetchData(
        apiHost: ApiConstants.STORAGE,
        endPoint: ApiConstants.SCREENS,
        version: "",
        responseType: ResponseType.FIREBASE_STORAGE);

    return MainModel.fromJson(response);
  }
}
