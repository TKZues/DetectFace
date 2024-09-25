import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/flushbar/flush_bar_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class HandleApi {
  static Future<dynamic> execute(
      Future<Response<dynamic>> functionDio, String message) async {
    //check internet
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      AppFlushBar.showError(navigatorKey.currentContext!,
          "Không có kết nối mạng, thực hiện kết nối và thử lại!");
      EasyLoading.dismiss(animation: true);
      return null;
    }
    try {
      var res = await functionDio;
      AppLogger.i("$message ${res.data}");
      return res;
    } on DioError catch (e) {
      AppLogger.i("Call API $message Failed: ${e.message}");
      String messageError = handleError(e);
      if (messageError != "") {
        AppFlushBar.showError(navigatorKey.currentContext!, messageError);
      }
      return null;
    }
  }

  static String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioError) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss(animation: true);
      }
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Kết nối đến hệ thống bị huỷ, vui lòng thử lại";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Kết nối đến hệ thống quá lâu, vui lòng thử lại";
          break;
        case DioErrorType.other:
          errorDescription =
              "Thiết bị không có kết nối internet, vui lòng thử lại";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Phản hồi hết hạn từ hệ thống, vui lòng thử lại";
          break;
        case DioErrorType.response:
          errorDescription =
              "Nhận được phản hồi không hợp lệ: ${error.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription =
              "Gửi kết nối đến hệ thống hết hạn, vui lòng thử lại";
          break;
      }
    } else {
      errorDescription = "Lỗi không xác định, vui lòng thử lại";
    }
    return errorDescription;
  }
}
