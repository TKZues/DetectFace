// ignore_for_file: constant_identifier_names, prefer_initializing_formals

enum ApiStatus {
  Success,
  EmptyData,
  Failed,
  ExpiredToken,
  ServerError,
  LoginInAnotherDevice
}

class BaseApiResponse{
  dynamic responseData;
  ApiStatus? status;

  BaseApiResponse({required dynamic responseData, required ApiStatus status}){
    this.responseData = responseData;
    this.status = status;
  }
}