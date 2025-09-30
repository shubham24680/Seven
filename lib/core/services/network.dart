enum ApiStatus { INITIAL, SUCCESS, LOADING, ERROR }

class Network<T> {
  ApiStatus apiStatus;
  String? successMessage;
  String? errorMessage;
  int apiErrorCount;

  Network({
    this.apiStatus = ApiStatus.INITIAL,
    this.successMessage,
    this.errorMessage,
    this.apiErrorCount = 0,
  });

  T setApiStatus(ApiStatus apiStatus,
      {String? successMessage, String? errorMessage}) {
    this.apiStatus = apiStatus;
    this.successMessage = successMessage;
    this.errorMessage = errorMessage;
    return this as T;
  }

  T count({int count = 1}) {
    apiErrorCount += count;
    return this as T;
  }

  T defaultCount() {
    apiErrorCount = 0;
    return this as T;
  }

  bool get isInitial => apiStatus == ApiStatus.INITIAL;
  bool get isSuccess => apiStatus == ApiStatus.SUCCESS;
  bool get isLoading => apiStatus == ApiStatus.LOADING;
  bool get isError => apiStatus == ApiStatus.ERROR;
}
