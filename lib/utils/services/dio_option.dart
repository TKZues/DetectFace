// ignore_for_file: constant_identifier_names, unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:ivms/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

const HANDLE401 = "HANDLE401";

class DioOption {
  Dio? client;
  int refreshTokenNumber = 0;

  Dio createDio({xFormUrl = false, addToken = true}) {
    refreshTokenNumber = 0;
    client = Dio();
    client!.options.connectTimeout = 40000;
    client!.interceptors.add(
        QueuedInterceptorsWrapper(onRequest: (RequestOptions options, handler) {
      if (xFormUrl == true) {
        options.headers
            .addAll({'content-type': 'application/x-www-form-urlencoded'});
      } else {
        // options.headers.addAll({'Content-Type': 'application/json'});
      }
      return handler.next(options);
    }, onResponse: (Response response, handler) async {
      // Do something with response data
      // return response; // continue
      try {
        //access_token không hợp lệ
        if (response.data
            .toString()
            .toLowerCase()
            .contains('"error_code": 401')) {
          // _reLogin();
          if (response.data is String) {
            response.data =
                '{"success": false, "message": "Hết hạn đăng nhập, vui lòng đăng nhập lại!"}';
          } else if (response.data is Map) {
            response.data['result'] = {
              "success": false,
              "message": "Hết hạn đăng nhập, vui lòng đăng nhập lại!"
            };
          }
        }
      } catch (er) {
        if (kDebugMode) {
          print('access_token: $er');
        }
      }
      return handler.next(response);
    }, onError: (DioError error, handler) async {
      error.error =
          "Có lỗi trong quá trình xử lý. Bạn vui lòng thực hiện lại hoặc báo với nhân viên kỹ thuật để được hỗ trợ.";
      final requestPath = error.requestOptions.path;
      final connectivityResult = await Connectivity().checkConnectivity();

      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        error.error =
            "Không có kết nối Internet. Vui lòng kiểm tra lại kết nối Internet.";
      } else {
        // if (!kReleaseMode) {
        try {
          if (error.type == DioErrorType.receiveTimeout ||
              error.type == DioErrorType.connectTimeout) {
            error.error =
                "Không thể kết nối tới máy chủ. Vui lòng kiểm tra lại kết nối Internet.";
          } else if (error.type == DioErrorType.response) {
            String errorMessage = '';
            Map<String, dynamic>? errorData;
            try {
              errorData = error.response?.data as Map<String, dynamic>?;
              errorMessage = errorData?['message'] as String? ?? '';
            // ignore: empty_catches
            } catch (e) {}

            if (errorMessage.trim().isEmpty && errorData != null) {
              try {
                final errorStatus =
                    errorData['status'] as Map<String, dynamic>?;
                errorMessage = errorStatus?['message'] as String? ?? '';
              // ignore: empty_catches
              } catch (e) {}
            }

            error.error = errorMessage.trim().isEmpty
                ? "Có lỗi trong quá trình xử lý. Bạn vui lòng thực hiện lại hoặc báo với nhân viên kỹ thuật để được hỗ trợ."
                : errorMessage;

            switch (error.response!.statusCode) {
              case 400:
              case 500:
                error.error = error.response?.data['status']['message'] ?? '';
                return handler
                    .next(CustomDioError(error, error.requestOptions));

              case 401:
                if (addToken) {
                  if (refreshTokenNumber >= 1) {
                    error.error = HANDLE401;
                    return handler
                        .next(CustomDioError(error, error.requestOptions));
                  } else {
                    return refreshToken(addToken, error, handler);
                  }
                }
                break;
              case 404:
                error.error = 'Trang truy cập không tồn tại.';
                return handler
                    .next(CustomDioError(error, error.requestOptions));
              // break;
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }

      return handler.next(CustomDioError(error, error.requestOptions));
      // CustomDioError(error, error.requestOptions);
    }));
    client!.interceptors.add(
      LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
          logPrint: printWrapped),
    );
    if (Platform.isAndroid) {
      (client!.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return client!;
  }

  // Future<void> _reLogin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(SharePreferenceKeys.IsLogin, false);
  //   Navigator.pushNamedAndRemoveUntil(
  //       navigatorKey.currentContext!, "/aicam_login", (route) => false);
  // }

  Future<void> setXAppData(RequestOptions options) async {
    List<Map<String, dynamic>> xdata = [];
  }

  void printWrapped(Object object) {
    String text = object.toString();
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => log(match.group(0) ?? ''));
  }

  Future<void> refreshToken(
      bool isLogin, DioError error, ErrorInterceptorHandler handler) async {}

  // ignore: unused_element
  Future<void> _retry(RequestOptions requestOptions,
      ErrorInterceptorHandler handler, String accessToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    try {
      final cloneReq = await client!.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
      return handler.resolve(cloneReq);
    } on DioError catch (error) {
      error.error = HANDLE401;
      return handler.next(CustomDioError(error, error.requestOptions));
    }
  }

  // ignore: unused_element
  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

class CustomDioError extends DioError {
  CustomDioError(DioError dioError, RequestOptions requestOptions)
      : super(
          requestOptions: dioError.requestOptions,
        ) {
    response = dioError.response;
    type = dioError.type;
    requestOptions = dioError.requestOptions;
    error = dioError.error;
  }

  @override
  String toString() {
    return error.toString();
  }
}
