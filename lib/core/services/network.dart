enum ApiStatus { DEFAULT, SUCCESS, INPROGRESS, FAILED }

class Network<T> {
  ApiStatus apiStatus;
  String? successMessage;
  String? errorMessage;
  T? data;
  int? statusCode;

  Network(
      {this.apiStatus = ApiStatus.DEFAULT,
      this.successMessage,
      this.errorMessage,
      this.data,
      this.statusCode});

  // Named constructors for convenience
  Network.initial()
      : apiStatus = ApiStatus.DEFAULT,
        successMessage = null,
        errorMessage = null,
        data = null,
        statusCode = null;

  Network.inProgress()
      : apiStatus = ApiStatus.INPROGRESS,
        successMessage = null,
        errorMessage = null,
        data = null,
        statusCode = null;

  Network.success({T? data, String? message, int? statusCode})
      : apiStatus = ApiStatus.SUCCESS,
        successMessage = message,
        errorMessage = null,
        data = data,
        statusCode = statusCode;

  Network.failure({String? message, int? statusCode})
      : apiStatus = ApiStatus.FAILED,
        successMessage = null,
        errorMessage = message,
        data = null,
        statusCode = statusCode;

  bool get isDefault => apiStatus == ApiStatus.DEFAULT;
  bool get isSuccess => apiStatus == ApiStatus.SUCCESS;
  bool get isInProgress => apiStatus == ApiStatus.INPROGRESS;
  bool get isFailed => apiStatus == ApiStatus.FAILED;
}
