enum ApiStatus { INITIAL, SUCCESS, LOADING, ERROR, EMPTY }

class Network {
  ApiStatus apiStatus;
  String? successMessage;
  String? errorMessage;

  Network(
      {this.apiStatus = ApiStatus.INITIAL,
      this.successMessage,
      this.errorMessage});

  bool get isInitial => apiStatus == ApiStatus.INITIAL;
  bool get isSuccess => apiStatus == ApiStatus.SUCCESS;
  bool get isLoading => apiStatus == ApiStatus.LOADING;
  bool get isError => apiStatus == ApiStatus.ERROR;
  bool get isEmpty => apiStatus == ApiStatus.EMPTY;
}
